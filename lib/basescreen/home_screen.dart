import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siren24/Models/user_details.dart';

import 'package:siren24/Sheets/bottom_sheet1.dart';
import 'package:siren24/Sheets/bottom_sheet2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:siren24/basescreen/path.dart';
import 'package:siren24/payments/payment.dart';
import 'package:siren24/profile/history.dart';
import 'package:siren24/profile/inviteFriends.dart';
import 'package:siren24/profile/notification.dart';
import 'package:siren24/profile/settings.dart';

import 'package:siren24/signup/signin.dart';
import 'package:siren24/state/api_calling.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:uuid/uuid.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_place/google_place.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../my-globals.dart' as globals;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMapCreated = false;
  late LatLng latlangposition;
  late LatLng destination_location;
  late String destination;
  // load image for marker
  Future<Uint8List> getBytesFromAsset(String path) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: pixelRatio.round() * 40);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //
  void subscribeToNotifications() async {
    String phone = '';
    final SharedPreferences pref = await SharedPreferences.getInstance();
    phone = pref.getString('phone_number')!;
    await FirebaseMessaging.instance.subscribeToTopic(phone);
    await FirebaseMessaging.instance.subscribeToTopic("all");
    await FirebaseMessaging.instance.subscribeToTopic("user");
  }

  List<Marker> myMarkers = [];
  // marker list
  late GoogleMapController _controller;
  // map controller
  late Position currentPosition;
  var geolocator = Geolocator();
  // current position
  void locatePosition() async {
    final Uint8List mylocationmarker =
        await getBytesFromAsset('assets/mylocationmarker.png');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    latlangposition = LatLng(position.latitude, position.longitude);
    // get my location
    globals.currlat = position.latitude;
    globals.currentlng = position.longitude;

    setState(() {
      myMarkers.add(
        Marker(
            markerId: MarkerId('myLocation'),
            position: latlangposition,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRose)),
      );
    });
    ApiCaller().UserLocationUpdate(position.latitude, position.longitude);
    CameraPosition cameraposition =
        CameraPosition(target: latlangposition, zoom: 16);
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraposition),
    );
  }

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(25.36, 85.9), zoom: 5);
  //initiqal position

  final _textcontroller = TextEditingController();
  //text controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late String searchAddr;

  var uuid = Uuid();
  String _sessionToken = "";
  List<dynamic> _placeList = [];
  List<dynamic> _destinationDetails = [];

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      LoadDetails();
    });
    subscribeToNotifications();
    loadimage();
    super.initState();
    _textcontroller.addListener(() {
      _onChanged();
    });
  }

  int flag = 1;
  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    if (flag == 1) {
      getSuggestion(_textcontroller.text);
    }
  }

  String kPLACES_API_KEY = "AIzaSyASODipwXRfzJNuFRN8lCaQeMnxLXSOvgQ";

  void getSuggestion(String input) async {
    if (input.length > 1) {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    }
  }

  double ht = 0.3;

  DetailsResponse? detailsResponse;

  int bottomsheet = -1;
  int _polylineCount = 1;

  changeMapMode() {
    getJsonFile("assets/light.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  int sug = 1;
  int dest = 0;
  int showsheet = 1;
  String _imagelink =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBSosYcX8VPrpuos_y96aBACA795fmUqppmQ&usqp=CAU";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String name = "User Name";
  Future<void> loadimage() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();
    _imagelink = SharedPrefrences.getString('profilepic')!;
  }

  LoadDetails() async {
    Timer(Duration(seconds: 5), () async {
      GetProfileDetails details = await ApiCaller().ProfileDetails();
      setState(() {
        name = details.name!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      changeMapMode();
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: SideDrawer(),
        body: Stack(
          children: [
            GoogleMap(
              gestureRecognizers: Set()
                ..add(Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer()))
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<ScaleGestureRecognizer>(
                    () => ScaleGestureRecognizer()))
                ..add(
                    Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer())),
              initialCameraPosition: _initialPosition,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              markers: Set.from(myMarkers),
              onMapCreated: (controller) async {
                isMapCreated = true;
                LocationPermission permission;
                permission = await Geolocator.requestPermission();
                setState(() {
                  _controller = controller;
                  locatePosition();
                });
              },
            ),
            Positioned(
              top: 10,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 16, top: 20, right: 16, bottom: 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          elevation: 3,
                          child: GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Icon(Icons.list),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: dest == 1
                            ? Material(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Container(
                                  width: width - 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 10),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showsheet = 1;
                                              dest = 0;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Icon(
                                              Icons.chevron_left_outlined,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            _textcontroller.text
                                                .substring(0, 30),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: showsheet == 1
                  ? DraggableScrollableSheet(
                      maxChildSize: 0.8,
                      initialChildSize: ht,
                      minChildSize: 0.03,
                      snap: true,
                      snapSizes: [0.2],
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.asset('assets/drawer.png'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Image.asset('assets/initial.png'),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'PICKUP',
                                              style: TextStyle(
                                                  color: Colors.grey.shade500),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'My current location',
                                              style: TextStyle(fontSize: 15),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 50,
                                        right: 40),
                                    child: Divider(
                                      thickness: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Image.asset('assets/destination.png'),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'DROP-OFF',
                                                style: TextStyle(
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 200,
                                                    child: TextField(
                                                      controller:
                                                          _textcontroller,
                                                      onTap: () {
                                                        setState(() {
                                                          sug = 0;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 12),
                                                        hintText:
                                                            "Add drop location",
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        _textcontroller.text =
                                                            "";
                                                        _placeList.clear();
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        color: Colors.grey,
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: sug == 0
                                        ? null
                                        : Text(
                                            'Start typing to get suggestions.....'),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _placeList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Image.asset(
                                                  'assets/destination.png'),
                                              title: Text(_placeList[index]
                                                  ["description"]),
                                              onTap: () async {
                                                setState(() {
                                                  flag = 0;
                                                  _textcontroller.text = "";
                                                  _textcontroller.text =
                                                      _placeList[index]
                                                          ["description"];
                                                  //   _placeList[index]["place_id"];
                                                  destination =
                                                      _placeList[index]
                                                          ["description"];
                                                });
                                                var googlePlace = GooglePlace(
                                                    kPLACES_API_KEY);
                                                detailsResponse =
                                                    await googlePlace.details
                                                        .get(
                                                            _placeList[index]
                                                                ["place_id"],
                                                            fields: "geometry");
                                                var lat = detailsResponse!
                                                    .result!
                                                    .geometry!
                                                    .location
                                                    ?.lat;
                                                var lng = detailsResponse!
                                                    .result!
                                                    .geometry!
                                                    .location
                                                    ?.lng;
                                                globals.destilat = lat;
                                                globals.destilng = lng;
                                                destination_location =
                                                    LatLng(lat!, lng!);
                                                setState(() {
                                                  myMarkers.add(
                                                    Marker(
                                                        markerId: MarkerId(
                                                            'destination'),
                                                        position:
                                                            LatLng(lat, lng),
                                                        icon: BitmapDescriptor
                                                            .defaultMarkerWithHue(
                                                                BitmapDescriptor
                                                                    .hueRose)),
                                                  );

                                                  _placeList.clear();
                                                  dest = 1;
                                                });
                                                showsheet = 0;

                                                CameraPosition cameraposition =
                                                    CameraPosition(
                                                        target:
                                                            LatLng(lat, lng),
                                                        zoom: 16);
                                                _controller.animateCamera(
                                                  CameraUpdate
                                                      .newCameraPosition(
                                                          cameraposition),
                                                );
                                                Timer(Duration(seconds: 4), () {
                                                  _showSheet('oh');
                                                });
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                                _placeList.clear();
                                                flag = 1;
                                              },
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                              thickness: 1,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : null,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            locatePosition();
          },
          backgroundColor: Color(0xffEE2417),
          child: Icon(Icons.gps_fixed),
        ),
      ),
    );
  }

  Drawer SideDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 275,
            color: Color(0Xff4C6EE5),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(_imagelink),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Colors.grey,
            ),
            title: Text('History'),
            onTap: () {
              Navigator.pushNamed(context, History.id);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
            title: Text('Notifications'),
            onTap: () {
              Navigator.pushNamed(context, Notifications.id);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.call,
              color: Colors.grey,
            ),
            title: Text('Call Help Center'),
            onTap: () {
              ApiCaller().launchPhoneDialer('9718459379');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.wallet_giftcard,
              color: Colors.grey,
            ),
            title: Text('Invite Friends'),
            onTap: () {
              Navigator.pushNamed(context, InviteFriends.id);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, Settings.id);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.grey,
            ),
            title: Text('Logout'),
            onTap: () async {
              ApiCaller().Logout();
              SharedPreferences SharedPrefrences =
                  await SharedPreferences.getInstance();
              await SharedPrefrences.clear();
              Navigator.pop(context, Sign_in.id);
            },
          ),
        ],
      ),
    );
  }

  void _showSheet(String destination) {
    showFlexibleBottomSheet<void>(
      minHeight: 0.1,
      initHeight: 0.1,
      maxHeight: 0.5,
      context: context,
      builder: (context, controller, offset) {
        return SingleChildScrollView(
          controller: controller,
          child: BottomSheetWidget1(
            // scrollController: controller,
            // bottomSheetOffset: offset,
            end: destination,
            proceed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Path_Navigate(
                      currentlocation: latlangposition,
                      destinationlocation: destination_location,
                      destinationname: _textcontroller.text.substring(0, 30),
                    ),
                  ));
            },
          ),
        );
      },
      anchors: [0.1, 0.5],
    );
  }
/*
  void _showSecondSheet() {
    showFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.5,
      maxHeight: 1,
      context: context,
      builder: (context, controller, offset) {
        return Bottomsheet2(
          booknow: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.pushNamed(context, SearchScreen.id);
          },
        );
      },
      anchors: [0, 0.5, 1],
    );
  }

  void _AvailableAmbulancesSheet() {
    showFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.66,
      maxHeight: 1,
      context: context,
      builder: (context, controller, offset) {
        return AvailableAmbulance();
      },
      anchors: [0, 0.5, 1],
    );
  }

  _addPolyline(List<LatLng>? _coordinates) {
    PolylineId id = PolylineId("poly$_polylineCount");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: Colors.blueAccent,
        points: _coordinates!,
        width: 10,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
      _polylineCount++;
    }); */

}
