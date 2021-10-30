import 'dart:async';
import 'dart:convert';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:rxtask/Database/dbhelper.dart';

class ViewAllFriendsBloc{
  late FriendsModel friendsModel;
  DbHelper dbHelper = DbHelper();
  BehaviorSubject<Future<int>> deleteFriendSubject = BehaviorSubject();
  late AnimationController animationController;
  late Animation degOneTranslationAnimation;
  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.259779513;
    return degree / unitRadian;
  }

  getFriendsData()=> Stream.fromFuture( dbHelper.getAllFriends());



  void dispose(){
    deleteFriendSubject.close();
  }
}