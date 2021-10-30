import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:rxtask/FriendInfo/View/FriendDetailsView.dart';
import 'package:rxtask/MapScreen/Bloc/MapScreenBloc.dart';
import 'package:rxtask/localization/localizations.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';

class FriendInfo extends StatelessWidget {
  FriendsModel friendModel;

  MapScreenBloc mapBloc;

  FriendInfo(this.friendModel, this.mapBloc);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.WHITE_COLOR,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(SizeConfig.padding * 2),
      ),
      height: SizeConfig.safeBlockVertical * 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.padding),
            child: CircleAvatar(
              radius: SizeConfig.safeBlockHorizontal * 10,
              backgroundImage: FileImage(
                File(friendModel.imagePath),
              ),
            ),
          ),
          Text(
            '${friendModel.firstName} ${friendModel.lastName}',
            style: TextStyle(
                color: AppColors.MAIN_COLOR,
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.titleFontSize),
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.padding / 2),
            child: Text(
              '${((mapBloc.calculateDistance(
                mapBloc.currentLatSubject.value,
                mapBloc.currentLongSubject.value,
                double.parse(friendModel.lat),
                double.parse(friendModel.long),
              )).toInt()).toString()} ${AppLocalizations.of(context)!.kmFromYou}',
              style: TextStyle(
                  color: AppColors.MAIN_COLOR,
                  fontSize: SizeConfig.textFontSize),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.padding / 1.5),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FriendInfoView(friendModel)));
              },
              child: Text(
                AppLocalizations.of(context)!.viewAllInfo,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: AppColors.BROUWN_COLOR,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.textFontSize),
              ),
            ),
          )
        ],
      ),
    );
  }
}
