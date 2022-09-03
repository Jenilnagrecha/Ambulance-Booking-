import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siren24/Models/user_details.dart';
import 'package:siren24/profile/my_profile.dart';
import 'package:siren24/state/api_calling.dart';

class Settings extends StatefulWidget {
  static String id = 'settings';

  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

Future<void> loadimage() async {
  final SharedPreferences SharedPrefrences =
      await SharedPreferences.getInstance();
  _imagelink = SharedPrefrences.getString('profilepic')!;
}

String name = "Username";
String _imagelink =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBSosYcX8VPrpuos_y96aBACA795fmUqppmQ&usqp=CAU";

class _SettingsState extends State<Settings> {
  LoadDetails() async {
    GetProfileDetails details = await ApiCaller().ProfileDetails();
    setState(() {
      name = details.name!;
    });
  }

  @override
  void initState() {
    LoadDetails();
    super.initState();
    loadimage();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 160,
              width: width,
              color: Color(0Xff4C6EE5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height - 160,
              color: Color(0XffF8F8F8),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MyProfile.id);
                    },
                    child: Container(
                      color: Colors.white,
                      height: 90,
                      width: width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            radius: 44,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(_imagelink),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            Icons.chevron_right,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 44,
                      width: width,
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Clear cache',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      String web =
                          "https://www.siren24.in/terms-and-conditions/";
                      ApiCaller().launchURL(web);
                    },
                    child: Container(
                      height: 44,
                      width: width,
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Terms and Privacy Policy',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      ApiCaller().launchPhoneDialer('+919718459379');
                    },
                    child: Container(
                      height: 44,
                      width: width,
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Contact us',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 44,
                      width: width,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
