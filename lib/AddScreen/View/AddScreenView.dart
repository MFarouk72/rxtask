import 'package:flutter/material.dart';
import 'package:rxtask/AddScreen/View/AddGenderDropDown.dart';
import 'package:rxtask/Commons/CommonWidgets/DefaultButton.dart';
import 'package:rxtask/Commons/CommonWidgets/DefultFormField.dart';
import 'package:rxtask/MapScreen/Bloc/MapScreenBloc.dart';
import 'package:rxtask/MapScreen/View/MapScreenView.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:rxtask/Commons/CommonBlocs/UserBloc.dart';
import 'package:rxtask/localization/localizations.dart';

class AddScreenView extends StatefulWidget {
  bool isProfile;

  AddScreenView(this.isProfile);

  @override
  _AddScreenViewState createState() => _AddScreenViewState();
}

class _AddScreenViewState extends State<AddScreenView> {
  late UserBloc userBloc;
  late MapScreenBloc mapScreenBloc;

  @override
  void initState() {
    super.initState();
    userBloc = UserBloc();
    mapScreenBloc = MapScreenBloc();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isProfile
            ? AppLocalizations.of(context)!.addYourProfileInfo
            : AppLocalizations.of(context)!.addNewFriends),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: userBloc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                userBloc.imagePath == null
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.padding / 2,
                            bottom: SizeConfig.padding / 2),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width: SizeConfig.safeBlockHorizontal * 50,
                                height: SizeConfig.safeBlockVertical * 15,
                                decoration: new BoxDecoration(
                                  color: AppColors.BROUWN_COLOR,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      userBloc.imageSelectorGallery();
                                    },
                                    icon: Icon(Icons.camera_alt),
                                    color: AppColors.WHITE_COLOR,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.padding / 2,
                              ),
                              Text(
                                AppLocalizations.of(context)!.photoValidation,
                                style: TextStyle(
                                  color: AppColors.RED_COLOR,
                                  fontSize: SizeConfig.textFontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.padding / 2,
                            bottom: SizeConfig.padding / 2,
                          ),
                          child: CircleAvatar(
                            radius: SizeConfig.safeBlockHorizontal * 19,
                            backgroundImage: FileImage(
                              userBloc.imagePath,
                            ),
                          ),
                        ),
                      ),
                DefaultFormField(
                  controller: userBloc.firstNameController,
                  type: DefaultFormFieldType.TEXT,
                  label: AppLocalizations.of(context)!.firstName,
                  subject: userBloc.firstNameSubject,
                  focusNode: userBloc.firstNameFocusNode,
                ),
                DefaultFormField(
                  controller: userBloc.lastNameController,
                  type: DefaultFormFieldType.TEXT,
                  label: AppLocalizations.of(context)!.lastName,
                  subject: userBloc.lastNameSubject,
                  focusNode: userBloc.lastNameFocusNode,
                ),
                DefaultFormField(
                  controller: userBloc.emailController,
                  type: DefaultFormFieldType.EMAIL,
                  label: AppLocalizations.of(context)!.email,
                  subject: userBloc.emailSubject,
                  focusNode: userBloc.emailFocusNode,
                ),
                AddGenderDropdownWidget(userBloc),
                DefaultFormField(
                  controller: userBloc.phoneController,
                  type: DefaultFormFieldType.PHONE,
                  label: AppLocalizations.of(context)!.phone,
                  subject: userBloc.phoneSubject,
                  focusNode: userBloc.phoneFocusNode,
                ),
                Padding(
                  padding: EdgeInsets.all(SizeConfig.padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.address,
                        style: TextStyle(
                          color: AppColors.BLACK_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.textFontSize,
                        ),
                      ),
                      StreamBuilder(
                          stream: MapScreenBloc.userMapAddressSubject.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Text(
                                snapshot.data.toString(),
                                style: TextStyle(
                                  color: AppColors.BLACK_COLOR,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.textFontSize,
                                ),
                              );
                            else
                              return SizedBox();
                          }),
                    ],
                  ),
                ),
                DefaultButton(
                  text: AppLocalizations.of(context)!.getYourAddressFromTheMap,
                  function: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MapScreenView(true)));
                  },
                ),
                DefaultButton(
                  text: AppLocalizations.of(context)!.save,
                  function: () {
                    if (userBloc.formKey.currentState!.validate() &&
                        userBloc.imagePath != null) {
                      userBloc.createNewFriend();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
