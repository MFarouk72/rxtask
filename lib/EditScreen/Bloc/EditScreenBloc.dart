import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxtask/Database/dbhelper.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxtask/MapScreen/Bloc/MapScreenBloc.dart';
import 'package:rxtask/localization/localizations.dart';
class EditScreenBloc{
  late FriendsModel friendsModel;
  EditScreenBloc(this.friendsModel);
  BehaviorSubject<String> firstNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> lastNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> emailSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> phoneSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> addressSubject = BehaviorSubject.seeded("");
  BehaviorSubject<bool> genderSubject = BehaviorSubject.seeded(true);
  BehaviorSubject<String> selectedGenderSubject = BehaviorSubject.seeded(AppLocalizations().male);
  Stream<String> get selectedGenderStream => selectedGenderSubject;
  BehaviorSubject<String> imagePathSubject = BehaviorSubject.seeded("");

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode idFocusNode = FocusNode();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  DbHelper dbHelper = DbHelper();
  getFriendData(){
    firstNameSubject.sink.add(friendsModel.firstName);
    lastNameSubject.sink.add(friendsModel.lastName);
    emailSubject.sink.add(friendsModel.email);
    phoneSubject.sink.add(friendsModel.phone);
    selectedGenderSubject.sink.add(friendsModel.gender);
    addressSubject.sink.add(friendsModel.address);
    imagePathSubject.sink.add(friendsModel.imagePath);

    firstNameController.text = friendsModel.firstName;
    lastNameController.text = friendsModel.lastName;
    emailController.text = friendsModel.email;
    phoneController.text = friendsModel.phone;
    addressController.text = friendsModel.address;
  }

  updateFriendInfo()  {
    FriendsModel updateFriends = FriendsModel({
      'id' : friendsModel.id,
      'firstName' : firstNameSubject.value,
      'lastName' : lastNameSubject.value,
      'email' : emailSubject.value,
      'phone' : phoneSubject.value,
      'address' : addressSubject.value,
      'gender' : selectedGenderSubject.value,
      'imagePath' : imagePathSubject.value,
      'lat' : friendsModel.lat,
      'long' : friendsModel.long,
    });
     dbHelper.editFriendInfo(updateFriends);
  }


  imageSelectorGallery() async {
    var galleryFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    print(galleryFile!.path);
      imagePathSubject.sink.add(galleryFile.path);
  }

  final Map<String, bool> genderMap = {
    AppLocalizations().male: true,
    AppLocalizations().female : false,
  };

  changeGender(String gender) {
    genderSubject.sink.add(genderMap[gender]!);
    selectedGenderSubject.sink.add(gender);
  }


  void dispose(){
    firstNameSubject.close();
    lastNameSubject.close();
    emailSubject.close();
    phoneSubject.close();
    addressSubject.close();
    genderSubject.close();
    imagePathSubject.close();
    selectedGenderSubject.close();
  }
}