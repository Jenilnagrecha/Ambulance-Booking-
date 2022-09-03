import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:siren24/state/api_calling.dart';
import 'package:siren24/Sheets/Driver_info.dart';
import 'package:siren24/basescreen/home_screen.dart';
import 'package:siren24/basescreen/rating.dart';
import 'package:siren24/Models/cancel_booking.dart';
import 'date_picker.dart';

class FareSummary extends StatefulWidget {
  final FlexibleDraggableScrollableSheetScrollController farecontroller;
  final int? total;
  final int? addonsprice;
  final int? ambprice;
  final String destinationname;
  final VoidCallback dates;

  FareSummary(
      {required this.farecontroller,
      required this.total,
      required this.destinationname,
      required this.addonsprice,
      required this.ambprice,
      required this.dates,
      Key? key})
      : super(key: key);

  @override
  State<FareSummary> createState() => _FareSummaryState();
}

class _FareSummaryState extends State<FareSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.white),
      child: ListView(
        controller: widget.farecontroller,
        children: [
          SizedBox(
            height: 40,
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
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              'Fare Summary',
              style: TextStyle(
                  fontSize: 17,
                  decoration: TextDecoration.none,
                  fontFamily: 'Roboto',
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  'Price for ambulance',
                  style: TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                Expanded(child: SizedBox()),
                Text(
                  widget.ambprice.toString(),
                  style: TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text(
                  'Add on',
                  style: TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                Expanded(child: SizedBox()),
                Text(
                  widget.addonsprice.toString(),
                  style: TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              height: 2,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Text(
                  'Total',
                  style: TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
                Expanded(child: SizedBox()),
                Text(
                  widget.total.toString(),
                  style: TextStyle(
                      fontSize: 17,
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await ApiCaller().BookNow();
                      DateTime now = DateTime.now();
                      FocusScope.of(context).requestFocus(FocusNode());
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  color: Colors.white),
                              height: 305,
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Image.asset('assets/check.png'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Booking Request sent',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'your request is sent to the driver\nwait for response',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  driver_info();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                        color: Color(0Xff4C6EE5),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
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
                          'Book Now',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              wordSpacing: 2,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Date_select.id);
                    },
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
                          'Book Later',
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              wordSpacing: 2,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void driver_info() {
    showFlexibleBottomSheet<void>(
      minHeight: 0.2,
      initHeight: 0.4,
      maxHeight: 0.4,
      isCollapsible: false,
      context: context,
      builder: (context, controller, offset) {
        return Driver_info(
          infocontroller: controller,
          cancel: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(
                        child: Text(
                      'Are you shure\nYou want to cancel booking',
                      textAlign: TextAlign.center,
                    )),
                    actions: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          CancelBooking reply = await ApiCaller()
                              .CancelOrder()
                              .whenComplete(() => () {
                                    Navigator.popAndPushNamed(
                                        context, HomeScreen.id);
                                  });
                          final snackBar = SnackBar(
                            content: Text(reply.message.toString()),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Container(
                          color: Colors.white,
                          width: 140,
                          height: 50,
                          child: Center(
                              child: Text(
                            'Yes',
                            style: TextStyle(
                                color: Color(0XFF4C6EE5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 3,
                        color: Colors.black,
                      ),
                      GestureDetector(
                        onTap: () {
                          //  Navigator.pop(context);
                          Navigator.pushNamed(context, RatingScreen.id);
                        },
                        child: Container(
                          color: Colors.white,
                          width: 140,
                          height: 50,
                          child: Center(
                              child: Text(
                            'No',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      )
                    ],
                  );
                });

            /*     Timer(Duration(seconds: 10), () {
              Navigator.pushNamed(context, RatingScreen.id);
            }); */
          },
        );
      },
      anchors: [0.2, 0.4],
    );
  }
}
