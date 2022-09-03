import 'dart:async';
//FuGYBSq6uZ5WavdER8MA6Cauy28PJEkfo2wmNvq7LbHe
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:siren24/Models/amblist.dart';
import 'package:siren24/profile/settings.dart';
import 'package:siren24/profile/settings.dart';
import 'package:siren24/state/api_calling.dart';
import '../my-globals.dart' as globals;

class AmbulanceList extends StatefulWidget {
  final FlexibleDraggableScrollableSheetScrollController controller;
  final VoidCallback next;
  final String destinationname;
  String ambulanceid;
  // final ScrollController scrollController;
  //final double bottomSheetOffset;
  AmbulanceList({
    required this.controller,
    required this.next,
    required this.destinationname,
    required this.ambulanceid,
    Key? key,
  }) : super(key: key);

  @override
  State<AmbulanceList> createState() => _AmbulanceListState();
}

class _AmbulanceListState extends State<AmbulanceList> {
  Future<List<AmbulancekiList>> future = ApiCaller().FetchAmb('als');
  int selected = 1;
  int selectedVehicle = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.white),
          child: ListView(
            controller: widget.controller,
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Image.asset(
                          'assets/verticle.png',
                          height: 25,
                          color: Colors.black,
                        ),
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Location',
                          style: TextStyle(
                              fontSize: 17,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          widget.destinationname,
                          style: TextStyle(
                              fontSize: 17,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 1;
                      });
                    },
                    child: Container(
                      height: 95,
                      width: 81,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: selected == 1
                            ? Color(0xff4C6EE5).withOpacity(0.5)
                            : Color(0xffF7F7F7),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset('assets/zxl.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ZLX',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 2;
                        future = ApiCaller().FetchAmb('als');
                      });
                    },
                    child: Container(
                      height: 95,
                      width: 81,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: selected == 2
                            ? Color(0xff4C6EE5).withOpacity(0.5)
                            : Color(0xffF7F7F7),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset('assets/abcl.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ABCL',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 3;
                        future = ApiCaller().FetchAmb('als');
                      });
                    },
                    child: Container(
                      height: 95,
                      width: 81,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: selected == 3
                            ? Color(0xff4C6EE5).withOpacity(0.5)
                            : Color(0xffF7F7F7),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset('assets/abcl1.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ABCL',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 4;
                        future = ApiCaller().FetchAmb('als');
                      });
                    },
                    child: Container(
                      height: 95,
                      width: 81,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: selected == 4
                            ? Color(0xff4C6EE5).withOpacity(0.5)
                            : Color(0xffF7F7F7),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Image.asset('assets/abcl1.png'),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ABCL',
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder<List<AmbulancekiList>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<AmbulancekiList>? data = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          Text('Add Ons..',
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, indexa) {
                              List<String>? addons =
                                  data![selectedVehicle].addons;
                              globals.ambulanceid = data[0].sId!;
                              globals.driverid = data[0].driverid!;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: addons!.length,
                                itemBuilder: (context, index1) {
                                  return Text('${addons[index1]}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          decoration: TextDecoration.none,
                                          fontFamily: 'Roboto',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400));
                                },
                              );
                            },
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.grey,
                          ),
                          Text('Available Ambulances..',
                              style: TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    globals.ambulanceid = data[index].sId!;

                                    setState(() {
                                      selectedVehicle = index;
                                      widget.ambulanceid =
                                          data[index].sId as String;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        // height: 60,
                                        width: width,
                                        decoration: index == selectedVehicle
                                            ? BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                color: Color(0xFFEDF0FC),
                                                border: Border.all(
                                                    color: Color(0xFF4C6EE4),
                                                    width: 2))
                                            : BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                color: Color(0XFFFAFAFA),
                                              ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                data[index].brand as String,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily: 'Roboto',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                ",",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily: 'Roboto',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                data[index].model as String,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily: 'Roboto',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Expanded(child: SizedBox()),
                                              Column(
                                                children: [
                                                  Text(
                                                    '430/-',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontFamily: 'Roboto',
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '2.5 Km',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration.none,
                                                        fontFamily: 'Roboto',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Divider(
                                          height: 2,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container();
                  }
                  return CircularProgressIndicator(
                      value: 20, color: Color(0xFF4C6EE4), strokeWidth: 4);
                },
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          width: width,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: widget.next,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Color(0xFF4C6EE4),
                  ),
                  height: 50,
                  child: Center(
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 19,
                          fontFamily: 'Roboto',
                          wordSpacing: 2,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
