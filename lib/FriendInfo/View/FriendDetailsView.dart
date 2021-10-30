import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:rxtask/EditScreen/View/EditScreenView.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:rxtask/localization/localizations.dart';

class FriendInfoView extends StatelessWidget {
  final FriendsModel friendsModel;
  FriendInfoView(this.friendsModel);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text( friendsModel.id == 1 ? AppLocalizations.of(context)!.profileScreen :AppLocalizations.of(context)!.friendInformation),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.all(SizeConfig.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.padding/ 2, bottom: SizeConfig.padding/ 2),
              child: CircleAvatar(
                radius: SizeConfig.safeBlockHorizontal * 19,
                backgroundImage: FileImage(
                  File(friendsModel.imagePath),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                 '${ friendsModel.firstName.toString().toUpperCase()} ${ friendsModel.lastName.toString().toUpperCase()} ',
                  style: TextStyle(
                    color:AppColors.BLACK_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.titleFontSize * 1.2,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> EditScreenView(friendsModel)));
                  },
                  child: Container(
                    width: SizeConfig.safeBlockHorizontal * 10,
                    height:  SizeConfig.safeBlockVertical * 5,
                    decoration: BoxDecoration(
                        color:AppColors.BLACK_COLOR, shape: BoxShape.circle
                    ),
                    child: Icon(Icons.edit, color: AppColors.WHITE_COLOR,),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.padding,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(SizeConfig.padding/2),
              ),
              margin: EdgeInsets.all(SizeConfig.padding/2),
              color:AppColors.MED_LIGHT_GREY,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.padding/2),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: SizeConfig.padding/2,),
                        Text(
                          ' ${friendsModel.email}',
                          style: TextStyle(
                            color: AppColors.BLACK_COLOR,
                            fontWeight: FontWeight.normal,
                            fontSize: SizeConfig.titleFontSize*1.2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.padding,
                    ),
                    Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: SizeConfig.padding/2,),
                        Expanded(
                          child: Text(
                            ' ${friendsModel.address}',
                            style: TextStyle(
                              color:AppColors.BLACK_COLOR,
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConfig.titleFontSize*1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.padding,
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width:SizeConfig.padding/2,),
                        Text(
                          ' ${friendsModel.phone}',
                          style: TextStyle(
                            color:AppColors.BLACK_COLOR,
                            fontWeight: FontWeight.normal,
                            fontSize: SizeConfig.titleFontSize*1.2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.padding,
                    ),
                    Row(
                      children: [
                        Icon(Icons.male),
                        SizedBox(width: SizeConfig.padding/2,),
                        Text(
                          ' ${friendsModel.gender}',
                          style: TextStyle(
                            color:AppColors.BLACK_COLOR,
                            fontWeight: FontWeight.normal,
                            fontSize: SizeConfig.titleFontSize*1.2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.padding,
                    ),
                    Row(
                      children: [
                        Icon(Icons.directions),
                        SizedBox(width: SizeConfig.padding/2,),
                        Expanded(
                          child: Text(
                            ' ${friendsModel.lat} ${" "} ${friendsModel.long} ',
                            maxLines: 3,
                            style: TextStyle(
                              color:AppColors.BLACK_COLOR,
                              fontWeight: FontWeight.normal,
                              fontSize: SizeConfig.titleFontSize*1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
