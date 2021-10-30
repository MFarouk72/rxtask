import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxtask/Commons/CommonModels/FriendsModel.dart';
import 'package:rxtask/Commons/CommonWidgets/DefaultButton.dart';
import 'package:rxtask/MapScreen/Bloc/MapScreenBloc.dart';
import 'package:rxtask/MapScreen/View/FriendInfoDialog.dart';
import 'package:rxtask/localization/localizations.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:custom_info_window/custom_info_window.dart';

class MapScreenView extends StatefulWidget {
  bool selectAddress;
  List<FriendsModel>? friendsList;

  MapScreenView(this.selectAddress, {this.friendsList});

  @override
  State<MapScreenView> createState() => _MapScreenViewState();
}

class _MapScreenViewState extends State<MapScreenView> {
  late MapScreenBloc mapScreenBloc;

  @override
  void initState() {
    super.initState();
    mapScreenBloc = MapScreenBloc(context: context);
    mapScreenBloc.getCurrentLocation();
    if (!widget.selectAddress) {
      for (int i = 0; i < widget.friendsList!.length; i++) {
        widget.friendsList![i].id == 1
            ? SizedBox()
            : mapScreenBloc.markerList.add(Marker(
                markerId: MarkerId(widget.friendsList![i].id.toString()),
                position: LatLng(double.parse(widget.friendsList![i].lat),
                    double.parse(widget.friendsList![i].long)),
                onTap: () {
                  mapScreenBloc.customInfoWindowController.addInfoWindow!(
                    FriendInfo(widget.friendsList![i],mapScreenBloc),
                    LatLng(double.parse(widget.friendsList![i].lat),
                        double.parse(widget.friendsList![i].long)),
                  );
                }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.mapScreen),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder(
          stream: mapScreenBloc.markerSubject.stream,
          builder: (context, snapshot) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: MapScreenBloc.myLatLng,
                  markers: Set.from(mapScreenBloc.markerList),
                  onCameraMove: (position) {
                    mapScreenBloc.customInfoWindowController.onCameraMove!();
                  },
                  onTap: !widget.selectAddress ?  (position){
                    mapScreenBloc.customInfoWindowController.hideInfoWindow!();
                  } : mapScreenBloc.handleTap ,
                  onMapCreated: (GoogleMapController controller) {
                    mapScreenBloc.mapController.complete(controller);
                    mapScreenBloc.newGoogleMapController = controller;
                    mapScreenBloc.getCurrentLocation();
                    mapScreenBloc.customInfoWindowController.googleMapController = controller;
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                ),
                CustomInfoWindow(
                  controller: mapScreenBloc.customInfoWindowController,
                  height: SizeConfig.safeBlockVertical * 27,
                  width: SizeConfig.safeBlockHorizontal *40,
                  offset: 50,
                ),
                widget.selectAddress
                    ? Positioned(
                        top: 13,
                        child: StreamBuilder(
                            stream: MapScreenBloc.userMapAddressSubject.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData)
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.WHITE_COLOR,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(SizeConfig.padding * 2),
                                  ),
                                  width: SizeConfig.safeBlockHorizontal * 65,
                                  height: SizeConfig.safeBlockVertical * 12,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(SizeConfig.padding/2),
                                        child: Center(
                                          child: Text(AppLocalizations.of(context)!.selectedLocation,
                                            style: TextStyle(
                                                color: AppColors.BLACK_COLOR),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: SizeConfig.padding/2, right: SizeConfig.padding/2, bottom: SizeConfig.padding/2),
                                          child: Center(
                                            child: Text('${snapshot.data.toString()}',
                                              style: TextStyle(
                                                  color: AppColors.BLACK_COLOR),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              else
                                return SizedBox();
                            }),
                      )
                    : SizedBox(),
                widget.selectAddress
                    ? Positioned(
                        child: DefaultButton(
                          text: AppLocalizations.of(context)!.save,
                          function: () {
                            Navigator.of(context).pop();
                          },
                          width: SizeConfig.safeBlockHorizontal * 50,
                        ),
                      )
                    : SizedBox(),
              ],
            );
          }),
    );
  }
}
