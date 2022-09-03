// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_const, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:siren24/basescreen/home_screen.dart';
import 'package:siren24/signup/signin.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({Key? key}) : super(key: key);
  static String id = 'onboarding_screens';

  @override
  _OnboardingScreensState createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  late PageController _onboarding;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _onboarding = PageController();
  }

  @override
  void dispose() {
    _onboarding.dispose();
    super.dispose();
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  nextFunction() {
    _onboarding.nextPage(duration: _kDuration, curve: _kCurve);
  }

  previousFunction() {
    _onboarding.previousPage(duration: _kDuration, curve: _kCurve);
  }

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: onChangedFunction,
                  controller: _onboarding,
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/requestride.png'),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Request Ride',
                            style: TextStyle(
                              fontFamily: 'SF UI Display',
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Request a ride and get picked up by\nnearbycommunity driver',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/confirm.png',
                            scale: 1.1,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Confirm Your Driver',
                            style: TextStyle(
                              fontFamily: 'SF UI Display',
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Huge driver networks help you to find\ncomfortable safe and cheap ride',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/track.png',
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Track Your Ride',
                            style: TextStyle(
                              fontFamily: 'SF UI Display',
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Know your driver in advance and be\nable to view current location in real time\non the map',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, Sign_in.id);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 92),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Color(0xFF4C6EE5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  'GET STARTED!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: size.height * .08,
            left: size.width * .5 - 25,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Indicator(
                    positionIndex: 0,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 1,
                    currentIndex: currentIndex,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Indicator(
                    positionIndex: 2,
                    currentIndex: currentIndex,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int positionIndex, currentIndex;
  const Indicator({required this.currentIndex, required this.positionIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: positionIndex == currentIndex
            ? Color(0xFF4C6EE5)
            : Color(0xFFF1F2F6),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
