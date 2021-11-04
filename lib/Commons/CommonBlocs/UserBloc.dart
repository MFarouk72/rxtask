import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxtask/Commons/CommonBlocs/PlayAudioBloc.dart';
import 'package:rxtask/Commons/CommonBlocs/RecordAudioBloc.dart';
import 'package:rxtask/Database/dbhelper.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxtask/MapScreen/Bloc/MapScreenBloc.dart';
import 'package:rxtask/localization/localizations.dart';
class UserBloc {
  var imagePath;
  BehaviorSubject<String> firstNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> lastNameSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> emailSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> phoneSubject = BehaviorSubject.seeded("");
  BehaviorSubject<String> addressSubject = BehaviorSubject.seeded("");
  BehaviorSubject<List<FriendsModel>> usersSubject = BehaviorSubject();
  BehaviorSubject<bool> genderSubject = BehaviorSubject.seeded(true);
  BehaviorSubject<String> selectedGenderSubject = BehaviorSubject.seeded(AppLocalizations().male);
  Stream<String> get selectedGenderStream => selectedGenderSubject;
  BehaviorSubject<String> imagePathSubject = BehaviorSubject.seeded("");
  TextEditingController idController = TextEditingController();
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

  createNewFriend(String audioPath) async {
    FriendsModel friendsModel = FriendsModel({
      'firstName' : firstNameSubject.value,
      'lastName' : lastNameSubject.value,
      'email' : emailSubject.value,
      'phone' : phoneSubject.value,
      'address' : MapScreenBloc.userMapAddressSubject.value,
      'gender' : selectedGenderSubject.value,
      'imagePath' : imagePathSubject.value,
      'lat' : MapScreenBloc.latitude.toString(),
      'long' : MapScreenBloc.longitude.toString(),
      'audioPath' : audioPath,
    });
    await dbHelper.addFriend(friendsModel);
  }

  imageSelectorGallery() async {
    var galleryFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    print(galleryFile!.path);
      imagePath = File(galleryFile.path);
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
    usersSubject.close();
    genderSubject.close();
    selectedGenderSubject.close();
    imagePathSubject.close();
  }

}
