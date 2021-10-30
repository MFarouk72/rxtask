import 'package:flutter/material.dart';
import 'package:rxtask/AboutApp/View/AboutAppView.dart';
import 'package:rxtask/AddScreen/View/AddScreenView.dart';
import 'package:rxtask/Commons/CommonWidgets/CircularButton.dart';
import 'package:rxtask/MapScreen/View/MapScreenView.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:rxtask/Database/dbhelper.dart';
import 'package:rxtask/EditScreen/View/EditScreenView.dart';
import 'package:rxtask/FriendInfo/View/FriendDetailsView.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:rxtask/ViewAllFriends/Bloc/ViewAllFriendsBloc.dart';
import 'package:rxtask/localization/localizations.dart';

class ViewAllFriendsView extends StatefulWidget {
  @override
  _ViewAllFriendsViewState createState() => _ViewAllFriendsViewState();
}

class _ViewAllFriendsViewState extends State<ViewAllFriendsView>
    with SingleTickerProviderStateMixin {
  late FriendsModel profileModel;
  late ViewAllFriendsBloc viewAllFriendsBloc;
  late DbHelper dbHelper;
  List<FriendsModel> friendsList = [];

  @override
  void initState() {
    super.initState();
    viewAllFriendsBloc = ViewAllFriendsBloc();
    viewAllFriendsBloc.animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    viewAllFriendsBloc.degOneTranslationAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(viewAllFriendsBloc.animationController);
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.yourFriends),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: viewAllFriendsBloc.getFriendsData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('${snapshot.data} snapshot datataaaaaaa ');
              if (snapshot.hasData && snapshot.data.length > 0) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      FriendsModel friendsModel =
                      FriendsModel.fromMap(snapshot.data[index]);
                      friendsList.add(friendsModel);
                      if (friendsModel.id == 1) {
                        profileModel = friendsModel;
                        return SizedBox();
                      } else {
                        return Card(
                          margin: EdgeInsets.all(SizeConfig.padding / 2),
                          color: AppColors.MED_LIGHT_GREY,
                          child: ListTile(
                            title: Text(
                              '${friendsModel.firstName} ${friendsModel.lastName}',
                              style: TextStyle(
                                color: AppColors.BLACK_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.titleFontSize,
                              ),
                            ),
                            subtitle: Text(
                              friendsModel.email,
                              style: TextStyle(
                                color: AppColors.BLACK_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.textFontSize,
                              ),
                            ),
                            trailing: Column(
                              children: [
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppColors.RED_COLOR,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        dbHelper.deleteFriend(friendsModel.id!);
                                        friendsList.remove(friendsModel);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: AppColors.GREEN_COLOR,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditScreenView(
                                                      friendsModel)));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      FriendInfoView(friendsModel)));
                            },
                          ),
                        );
                      }
                    });
              } else {
                return Center(
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: AppColors.BLACK_COLOR,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddScreenView(true)));
                    },
                  ),
                );
              }
            },
          ),
          Positioned(
            bottom: 30 ,
            right: 30,
            child: AnimatedBuilder(
              animation: viewAllFriendsBloc.animationController,
              builder: (BuildContext context, Widget? child) {
               return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    IgnorePointer(
                      child: Container(
                        color: Colors.transparent,
                        height: 150.0,
                        width: 150.0,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(
                          viewAllFriendsBloc.getRadiansFromDegree(270),
                          viewAllFriendsBloc.degOneTranslationAnimation.value *
                              100),
                      child: CircularButton(
                          color: AppColors.BLUE_COLOR,
                          icon: Icon(
                            Icons.add,
                            color: AppColors.WHITE_COLOR,
                          ),
                          onClick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddScreenView(true)));
                          }),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(
                          viewAllFriendsBloc.getRadiansFromDegree(235),
                          viewAllFriendsBloc.degOneTranslationAnimation.value *
                              100),
                      child: CircularButton(
                          color: AppColors.BLACK_COLOR,
                          icon: Icon(
                            Icons.person,
                            color: AppColors.WHITE_COLOR,
                          ),
                          onClick: () {
                            if (profileModel.id == 1) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      FriendInfoView(profileModel)));
                            }
                          }),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(
                          viewAllFriendsBloc.getRadiansFromDegree(200),
                          viewAllFriendsBloc.degOneTranslationAnimation.value *
                              100),
                      child: CircularButton(
                          color: AppColors.TAB_SELECTED_COLOR,
                          icon: Icon(
                            Icons.location_on_sharp,
                            color: AppColors.WHITE_COLOR,
                          ),
                          onClick: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MapScreenView(false, friendsList: friendsList,)));
                          }),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(
                          viewAllFriendsBloc.getRadiansFromDegree(165),
                          viewAllFriendsBloc.degOneTranslationAnimation.value *
                              100),
                      child: CircularButton(
                          color: AppColors.BROUWN_COLOR,
                          icon: Icon(
                            Icons.help,
                            color: AppColors.WHITE_COLOR,
                          ),
                          onClick: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AboutAppView()));
                          }),
                    ),
                    CircularButton(
                        width: 60,
                        height: 60,
                        color: AppColors.RED_COLOR,
                        icon: Icon(
                          Icons.menu,
                          color: AppColors.WHITE_COLOR,
                        ),
                        onClick: () {
                          if (viewAllFriendsBloc.animationController.isCompleted) {
                            viewAllFriendsBloc.animationController.reverse();
                          } else {
                            viewAllFriendsBloc.animationController.forward();
                          }
                        }),
                  ],
               );
              },
            ),
          ),
        ],
      ),
    );
  }
}