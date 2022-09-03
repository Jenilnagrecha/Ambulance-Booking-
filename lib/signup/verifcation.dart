import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:siren24/basescreen/home_screen.dart';
import 'package:siren24/state/api_calling.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);
  static String id = 'otp_verification';

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  OtpFieldController otpController = OtpFieldController();
  late String otp;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.24,
                width: width,
                color: Color(0Xff4C6EE5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14, right: 14, bottom: 14),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Phone Verification',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Enter your OTP code here',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 0.76 * height - 40,
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      OTPTextField(
                        length: 6,
                        controller: otpController,
                        width: width - 100,
                        fieldWidth: 40,
                        style: TextStyle(fontSize: 17),
                        fieldStyle: FieldStyle.underline,
                        onCompleted: (pin) {
                          otp = pin;
                        },
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          var int_otp = int.parse(otp);
                          ApiCaller().verifyOtp(int_otp);
                          Navigator.pushNamed(context, HomeScreen.id);
                        },
                        child: Center(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Color(0Xff4C6EE5),
                            ),
                            height: 50,
                            width: 340,
                            child: Center(
                              child: Text(
                                'Verify now',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
