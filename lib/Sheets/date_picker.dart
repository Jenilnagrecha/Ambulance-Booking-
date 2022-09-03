import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siren24/state/api_calling.dart';
import '../Models/cancel_booking.dart';
import '../basescreen/home_screen.dart';
import '../basescreen/rating.dart';
import 'Driver_info.dart';

class Date_select extends StatefulWidget {
  static String id = 'date_picker';
  Date_select({Key? key}) : super(key: key);

  @override
  State<Date_select> createState() => _Date_selectState();
}

class _Date_selectState extends State<Date_select> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  late String _hour, _minute, _time;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        height: height / 2,
        child: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    initialDatePickerMode: DatePickerMode.day,
                    firstDate: DateTime(2015),
                    lastDate: DateTime(2101));
                if (picked != null)
                  setState(() {
                    selectedDate = picked;
                    _dateController.text =
                        DateFormat.yMd().format(selectedDate);
                  });
              },
              child: TextFormField(
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
                enabled: false,
                keyboardType: TextInputType.text,
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: 'Pick Date',
                  contentPadding: EdgeInsets.all(10),
                  focusColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null)
                  setState(() {
                    selectedTime = picked;
                    _timeController.text = picked.toString();
                  });
              },
              child: TextFormField(
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
                enabled: false,
                keyboardType: TextInputType.text,
                controller: _timeController,
                decoration: InputDecoration(
                  hintText: 'Pick Time',
                  contentPadding: EdgeInsets.all(10),
                  focusColor: Colors.black,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
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
                  onTap: () async {
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
                                    'Booking Sucessful',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Your booking has been rendered successfully\nWe will get back to you in few minutes',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            GestureDetector(
                              onTap: () {
                                if (_dateController.text != null &&
                                    _timeController.text != null) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  driver_info();
                                }
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
                      child: GestureDetector(
                        onTap: () async {
                          final p = await ApiCaller().BookLater();
                        },
                        child: Text(
                          'Confirm',
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
            ),
          ],
        ),
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
