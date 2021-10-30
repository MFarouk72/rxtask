import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rxtask/Commons/CommonWidgets/DefaultButton.dart';
import 'package:rxtask/Commons/CommonWidgets/DefultFormField.dart';
import 'package:rxtask/EditScreen/View/EditGenderDropDown.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:rxtask/EditScreen/Bloc/EditScreenBloc.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:rxtask/localization/localizations.dart';

class EditScreenView extends StatefulWidget {
  final FriendsModel friendsModel;
  EditScreenView(this.friendsModel);
  @override
  _EditScreenViewState createState() => _EditScreenViewState();
}

class _EditScreenViewState extends State<EditScreenView> {
  late EditScreenBloc editScreenBloc;
  @override
  void initState() {
    super.initState();
    editScreenBloc = EditScreenBloc(widget.friendsModel);
    editScreenBloc.getFriendData();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editFriendInformation),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: editScreenBloc.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    StreamBuilder(
                      stream: editScreenBloc.imagePathSubject.stream,
                      builder: (context, snapshot) {
                         if(!snapshot.hasData){
                           return Container(
                             color: AppColors.BROUWN_COLOR,
                             width: SizeConfig.safeBlockHorizontal * 50,
                             height:  SizeConfig.safeBlockVertical * 15,
                             child: Center(
                               child: IconButton(
                                 onPressed: () {
                                   editScreenBloc.imageSelectorGallery();
                                 },
                                 icon: Icon(Icons.camera_alt),
                                 color: AppColors.WHITE_COLOR,
                               ),
                             ),
                           );
                        }
                         else{
                          return Stack(
                            children: [
                              CircleAvatar(
                                radius: SizeConfig.safeBlockHorizontal * 19,
                                backgroundImage: FileImage(
                                  File(snapshot.data.toString()),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 15,
                                  height: SizeConfig.safeBlockVertical * 6,
                                  decoration: BoxDecoration(
                                      color: AppColors.BROUWN_COLOR, shape: BoxShape.circle),
                                  child: IconButton(icon: Icon(Icons.camera_alt, color: AppColors.WHITE_COLOR,size: 20,), onPressed: () {
                                    editScreenBloc.imageSelectorGallery();
                                  },),
                                ),
                              ),
                            ],
                          );
                         }
                      }
                    ),
                  ],
                ),

                DefaultFormField(
                  controller: editScreenBloc.firstNameController,
                  type: DefaultFormFieldType.TEXT,
                  label: AppLocalizations.of(context)!.firstName,
                  subject: editScreenBloc.firstNameSubject,
                  focusNode: editScreenBloc.firstNameFocusNode,
                ),
                DefaultFormField(
                  controller: editScreenBloc.lastNameController,
                  type: DefaultFormFieldType.TEXT,
                  label: AppLocalizations.of(context)!.lastName,
                  subject: editScreenBloc.lastNameSubject,
                  focusNode: editScreenBloc.lastNameFocusNode,
                ),
                DefaultFormField(
                  controller: editScreenBloc.emailController,
                  type: DefaultFormFieldType.EMAIL,
                  label: AppLocalizations.of(context)!.email,
                  subject: editScreenBloc.emailSubject,
                  focusNode: editScreenBloc.emailFocusNode,
                ),
                EditGenderDropdownWidget(editScreenBloc),
                DefaultFormField(
                  controller: editScreenBloc.phoneController,
                  type: DefaultFormFieldType.PHONE,
                  label: AppLocalizations.of(context)!.phone,
                  subject: editScreenBloc.phoneSubject,
                  focusNode: editScreenBloc.phoneFocusNode,
                ),
                DefaultFormField(
                  controller: editScreenBloc.addressController,
                  type: DefaultFormFieldType.TEXT,
                  label: AppLocalizations.of(context)!.address,
                  subject: editScreenBloc.addressSubject,
                  focusNode: editScreenBloc.addressFocusNode,
                ),
                DefaultButton(
                  text: AppLocalizations.of(context)!.edit,
                  function: () {
                    if(editScreenBloc.formKey.currentState!.validate()){
                    editScreenBloc.updateFriendInfo();
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
