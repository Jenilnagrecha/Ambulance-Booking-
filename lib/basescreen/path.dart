import 'dart:async';
import 'dart:ffi';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:siren24/Models/cancel_booking.dart';
import 'package:siren24/Models/fare_summary.dart';
import 'package:siren24/Sheets/Driver_info.dart';
import 'package:siren24/Sheets/add_on_list.dart';
import 'package:siren24/Sheets/amb_list.dart';
import 'package:siren24/Sheets/date_picker.dart';
import 'package:siren24/Sheets/fare_summary.dart';
import 'package:siren24/basescreen/home_screen.dart';
import 'package:siren24/basescreen/rating.dart';
import 'package:siren24/state/api_calling.dart';
import '../my-globals.dart' as globals;

class Path_Navigate extends StatefulWidget {
  static String id = 'path_screen';
  final LatLng currentlocation;
  final LatLng destinationlocation;
  final String destinationname;
  const Path_Navigate(
      {Key? key,
      required this.currentlocation,
      required this.destinationlocation,
      required this.destinationname})
      : super(key: key);

  @override
  _Path_NavigateState createState() => _Path_NavigateState();
}

class _Path_NavigateState extends State<Path_Navigate> {
  String Ambulanceid = " ";
  Color color1 = Color(0xffF7F7F7);
  Color color2 = Color(0xffF7F7F7);
  Color color3 = Color(0xffF7F7F7);
  Color color4 = Color(0xffF7F7F7);
  late GoogleMapController _Pathmapcontroller;
  List<Marker> pathMarkers = [];
  MapsRoutes route = new MapsRoutes();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  String googleApiKey = 'AIzaSyASODipwXRfzJNuFRN8lCaQeMnxLXSOvgQ';
  String totalDistance = 'No route';
  changeMapMode() {
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _Pathmapcontroller.setMapStyle(mapStyle);
  }

  bool isMapCreated = false;
  int selected = 0;
  String cancelreply = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (isMapCreated) {
      changeMapMode();
    }
    return Scaffold(
      body: GoogleMap(
        gestureRecognizers: Set()
          ..add(Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer()))
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        initialCameraPosition:
            CameraPosition(target: widget.currentlocation, zoom: 15),
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        markers: Set.from(pathMarkers),
        polylines: route.routes,
        onMapCreated: (controller) async {
          isMapCreated = true;
          List<LatLng> points = [
            widget.currentlocation,
            widget.destinationlocation,
          ];
          await route.drawRoute(
              points, 'Test routes', Color(0Xff4C6EE5), googleApiKey,
              travelMode: TravelModes.driving);
          setState(() {
            _Pathmapcontroller = controller;
            totalDistance =
                distanceCalculator.calculateRouteDistance(points, decimals: 1);
            // globals.totaldistance = (totalDistance);

            String distancestring =
                totalDistance.substring(0, totalDistance.length - 3);

            globals.totaldistance = distancestring;

            addCurrentLocation();
            adddestination();
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAmbulance();
        },
        child: Icon(Icons.directions_car),
      ),
    );
  }

  void adddestination() {
    setState(() {
      pathMarkers.add(
        Marker(
            markerId: MarkerId('destinationlocation'),
            position: widget.destinationlocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRose)),
      );
    });
  }

  void _showAmbulance() {
    showFlexibleBottomSheet<void>(
      minHeight: 0.3,
      initHeight: 0.6,
      maxHeight: 0.6,
      isCollapsible: false,
      context: context,
      builder: (context, controller, offset) {
        return AmbulanceList(
          controller: controller,
          destinationname: widget.destinationname,
          ambulanceid: Ambulanceid,
          next: () {
            // _fareSummary();
            addonsSheet();
          },
        );
      },
      anchors: [0.3, 0.5],
    );
  }

  Future<void> _fareSummary() async {
    FareKiSummary fare = await ApiCaller().GetFareSummary();
    globals.drivername = fare.driverName!;
    globals.driverphone = fare.driverPhoneno!;
    globals.drrating = fare.driverRating!;
    globals.vhno = fare.carNo!;
    globals.drimage = fare.driverImg!;
    globals.amount = fare.totalPrice!;

    showFlexibleBottomSheet<void>(
      minHeight: 0.3,
      initHeight: 0.6,
      maxHeight: 0.6,
      isCollapsible: false,
      context: context,
      builder: (context, controller, offset) {
        return FareSummary(
          farecontroller: controller,
          total: fare.totalPrice,
          ambprice: fare.price,
          addonsprice: fare.addons,
          destinationname: widget.destinationname,
          dates: () {
            DateSheet();
          },
        );
      },
      anchors: [0.3, 0.5],
    );
  }

  Future<void> DateSheet() async {
    showFlexibleBottomSheet<void>(
      minHeight: 0.3,
      initHeight: 0.6,
      maxHeight: 0.6,
      isCollapsible: false,
      isDismissible: false,
      context: context,
      builder: (context, controller, offset) {
        return Date_select();
      },
      anchors: [0.3, 0.5],
    );
  }

  void addonsSheet() {
    showFlexibleBottomSheet<void>(
      minHeight: 0.3,
      initHeight: 0.6,
      maxHeight: 0.6,
      isCollapsible: false,
      context: context,
      builder: (context, controller, offset) {
        return AddOnList(
          addoncontroller: controller,
          ambid: Ambulanceid,
          addnext: () {
            _fareSummary();
          },
        );
      },
      anchors: [0.3, 0.5],
    );
  }

  void addCurrentLocation() {
    setState(() {
      pathMarkers.add(
        Marker(
            markerId: MarkerId('myLocation'),
            position: widget.currentlocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRose)),
      );
    });

    CameraPosition cameraposition =
        CameraPosition(target: widget.currentlocation, zoom: 11);
    _Pathmapcontroller.animateCamera(
      CameraUpdate.newCameraPosition(cameraposition),
    );
  }
}
