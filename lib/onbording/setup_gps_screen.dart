import 'package:flutter/material.dart';

// ignore: camel_case_types
class setup_gps_screen extends StatefulWidget {
  static String id = 'setup_gps_screen';
  const setup_gps_screen({Key? key}) : super(key: key);

  @override
  _setup_gps_screenState createState() => _setup_gps_screenState();
}

// ignore: camel_case_types
class _setup_gps_screenState extends State<setup_gps_screen> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/Page1.png'),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Hi, nice to meet you! ',
                        style: TextStyle(
                          fontFamily: 'SF UI Display',
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: const Text(
                                'Choose your location to start find restaurants around you.',
                                style: TextStyle(
                                  fontFamily: 'SF UI Display',
                                  color: Color.fromRGBO(200, 199, 204, 1),
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ))),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: 304,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/Path.png',
                                height: 50,
                                width: 50,
                              ),
                              const Text(
                                'Use current location',
                                style: TextStyle(
                                  fontFamily: 'SF UI Display',
                                  color: Color.fromRGBO(76, 110, 229, 1),
                                  fontSize: 17,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Select it manually',
                        style: TextStyle(
                            fontFamily: 'SF UI Display',
                            // decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            color: Colors.transparent,
                            // fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  offset: Offset(0, -5),
                                  color: Color.fromRGBO(245, 45, 86, 1))
                            ],
                            decoration: TextDecoration.underline,
                            // decorationStyle: TextDecorationStyle.dashed,
                            decorationColor: Color.fromRGBO(245, 45, 86, 1),
                            fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
