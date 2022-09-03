import 'dart:async';

import 'package:flutter/material.dart';
import 'package:siren24/onbording/OnboardingScreens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siren24/state/api_calling.dart';

import '../basescreen/home_screen.dart';

class Splash_Screen extends StatefulWidget {
  static String id = 'Splashscreen';
  Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  String? _authToken = " ";
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 2), () {
        if (_authToken != " ") {
          Navigator.pushNamed(context, HomeScreen.id);
        } else {
          Navigator.pushNamed(context, OnboardingScreens.id);
        }
      });
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    setState(() {
      String? tkn = SharedPrefrences.getString('authtoken');
      if (tkn != null) {
        _authToken = tkn;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Column(
          children: [
            Expanded(child: SizedBox()),
            Image.asset('assets/mainlogo.png'),
            Image.asset('assets/Oval.png'),
            Text(
              'Siren 24',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  letterSpacing: 4),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
