import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rxdart/rxdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:custom_info_window/custom_info_window.dart';

class MapScreenBloc {
  BuildContext? context;
  MapScreenBloc({this.context});
  static double? latitude;
  static double? longitude;
  BehaviorSubject<double> currentLatSubject = BehaviorSubject();
  BehaviorSubject<double> currentLongSubject = BehaviorSubject();
  BehaviorSubject<Marker> markerSubject = BehaviorSubject();
  static BehaviorSubject<String> userMapAddressSubject = BehaviorSubject();
  Completer<GoogleMapController> mapController = Completer();
  late GoogleMapController newGoogleMapController;
  CustomInfoWindowController customInfoWindowController = CustomInfoWindowController();
  List<Marker> markerList = [];

  handleTap(LatLng tappedPoint) {
    markerList = [];
    markerSubject.sink.add(
      Marker(
        markerId: MarkerId(
          tappedPoint.toString(),
        ),
        position: tappedPoint,
      ),

    );
    latitude = tappedPoint.latitude;
    longitude = tappedPoint.longitude;
    markerList.add(markerSubject.value);
    getAddressFromLatLong(tappedPoint);
  }

  static CameraPosition myLatLng = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );

  Future<void> getAddressFromLatLong(LatLng position) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMarks[0];
    userMapAddressSubject.sink.add('${place.street.toString()}${","}${place.administrativeArea.toString()}${","}${place.country.toString()}');
    print('the address from bloc isssssssssss ${userMapAddressSubject.value}');
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      LatLng latlngPostion = LatLng(position.latitude,position.longitude);
      currentLatSubject.sink.add(position.latitude);
      currentLongSubject.sink.add(position.longitude);
      CameraPosition cameraPosition = CameraPosition(target: latlngPostion, zoom: 10);
      newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } catch (e) {
      print(e);
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  void dispose() {
    markerSubject.close();
    userMapAddressSubject.close();
    currentLatSubject.close();
    currentLongSubject.close();
    customInfoWindowController.dispose();
  }
}
