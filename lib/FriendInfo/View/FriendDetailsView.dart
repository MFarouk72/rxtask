import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxtask/Commons/CommonBlocs/PlayAudioBloc.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:rxtask/EditScreen/View/EditScreenView.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:rxtask/localization/localizations.dart';

class FriendInfoView extends StatefulWidget {
  final FriendsModel friendsModel;
  FriendInfoView(this.friendsModel);

  @override
  State<FriendInfoView> createState() => _FriendInfoViewState();
}

class _FriendInfoViewState extends State<FriendInfoView> {
  late PlayAudioBloc playAudioBloc;
  @override
  void initState() {
    super.initState();
    playAudioBloc = PlayAudioBloc();
    playAudioBloc.init();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.friendsModel.id == 1 ? AppLocalizations.of(context)!.profileScreen :AppLocalizations.of(context)!.friendInformation),
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
                  File(widget.friendsModel.imagePath),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                 '${ widget.friendsModel.firstName.toString().toUpperCase()} ${ widget.friendsModel.lastName.toString().toUpperCase()} ',
                  style: TextStyle(
                    color:AppColors.BLACK_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.titleFontSize * 1.2,
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> EditScreenView(widget.friendsModel)));
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
                          ' ${widget.friendsModel.email}',
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
                            ' ${widget.friendsModel.address}',
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
                          ' ${widget.friendsModel.phone}',
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
                          ' ${widget.friendsModel.gender}',
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
                            ' ${widget.friendsModel.lat} ${" "} ${widget.friendsModel.long} ',
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
                    buildPlay(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlay() {
    final isPlaying = playAudioBloc.isPlaying;
    final icon = isPlaying ? Icons.stop : Icons.play_arrow;
    final text = isPlaying ? 'STOP' : 'Play';
    final primary = isPlaying ? Colors.red : AppColors.BROUWN_COLOR;
    final onPrimary = isPlaying ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(175, 50),
        primary: primary,
        onPrimary: onPrimary,
      ),
      onPressed: () async {
        // await playAudioBloc.togglePlayStop(path: widget.friendsModel.audioPath, whenFinished: (){});
        await playAudioBloc.togglePlayStop(widget.friendsModel.audioPath);
        setState(() {
        });
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }

  @override
  void dispose() {
    playAudioBloc.dispose();
    super.dispose();
  }
}
