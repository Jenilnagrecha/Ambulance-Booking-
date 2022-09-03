import 'package:flutter/material.dart';
import 'package:siren24/signup/verifcation.dart';
import 'package:siren24/state/api_calling.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);
  static String id = 'sign_in';

  @override
  _Sign_inState createState() => _Sign_inState();
}

final _textController = TextEditingController();

@override
void dispose() {
  _textController.dispose();
}

class _Sign_inState extends State<Sign_in> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: height / 2,
                  color: Color(0Xff4C6EE5),
                ),
                Container(
                  height: height / 2,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height / 2 - 150,
                      ),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          height: 50,
                          width: 340,
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  'G',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Connect with Google',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          height: 50,
                          width: 340,
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  'f',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Connect with Facebook',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0.30 * height,
              right: 20,
              left: 20,
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  height: 362,
                  width: 343,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          'Login with your phone number',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 45,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _textController,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              suffix: IconButton(
                                  onPressed: () {
                                    _textController.text = "";
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                  },
                                  icon: Icon(
                                    Icons.cancel_rounded,
                                    color: Colors.grey,
                                  )),
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
                      ),
                      Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () {
                          var phone_no = int.parse(_textController.text);
                          ApiCaller().sendOtpToPhone(phone_no);
                          Navigator.pushNamed(context, OtpVerification.id);
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
                                'Next',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//Dnzyp641szsd52BUhm3nSEvwgDoAGzRepw4LCPLn1L1V