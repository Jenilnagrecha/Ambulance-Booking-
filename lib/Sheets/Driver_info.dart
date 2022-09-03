import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:siren24/my-globals.dart';
import 'package:siren24/state/api_calling.dart';
import '../my-globals.dart' as globals;

class Driver_info extends StatefulWidget {
  final FlexibleDraggableScrollableSheetScrollController infocontroller;
  final VoidCallback cancel;

  Driver_info({required this.infocontroller, required this.cancel, Key? key})
      : super(key: key);

  @override
  State<Driver_info> createState() => _Driver_infoState();
}

class _Driver_infoState extends State<Driver_info> {
  Container check() {
    if (bookingSuccessful)
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: Colors.white),
        child: ListView(
          controller: widget.infocontroller,
          children: [
            Container(
              height: 68,
              color: Color(0XFFF7F7F7),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(globals.drimage),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          globals.drivername,
                          style: TextStyle(
                              fontSize: 17,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Image.asset('assets/star.png'),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              globals.drrating.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  fontFamily: 'Roboto',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        ApiCaller()
                            .launchPhoneDialer(globals.driverphone.toString());
                      },
                      child: Image.asset('assets/call.png'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 76,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Row(
                    children: [
                      Image.asset('assets/ambsymb.png'),
                      Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Vehicle No.',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  color: Colors.grey,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              globals.vhno,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Column(
                          children: [
                            Text(
                              'Vehicle Type',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  decoration: TextDecoration.none,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' ALSW1',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Container(
              height: 76,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  children: [
                    Image.asset('assets/road.png'),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: [
                          Text(
                            'Distance',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                color: Colors.grey,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            globals.totaldistance,
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.none,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            globals.amount.toString(),
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: widget.cancel,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Color(0xFF242E42),
                    ),
                    height: 50,
                    child: Center(
                      child: Text(
                        'Cancel Request',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            wordSpacing: 1,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return check();
  }
}
