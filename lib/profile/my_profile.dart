import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:siren24/Models/user_details.dart';
import 'package:siren24/state/api_calling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);
  static String id = 'my_profile';

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String birthDateInString = "Update your birth date";
  DateTime birthDate = DateTime.now();
  Object? _value = 1;
  String userName = "Update username";
  String userEmail = "Update email";
  int Phone = 0;
  String downloadurl = '';
  String _imagelink =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBSosYcX8VPrpuos_y96aBACA795fmUqppmQ&usqp=CAU";
  LoadDetails() async {
    GetProfileDetails details = await ApiCaller().ProfileDetails();
    setState(() {
      userName = details.name!;
      userEmail = details.address!;
      birthDateInString = details.dob!;
      Phone = details.phoneno!;
      //  _imagelink = details.profileImg!;
    });
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();
  }

/*   final ImagePicker _picker = ImagePicker();
  XFile? _image;
  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    File profileImage = File(image!.path);
    ApiCaller().fileUploader("profileimage", profileImage, "jpeg");
    GetProfileDetails details = await ApiCaller().ProfileDetails();
    
    setState(() {
      _image = image;
      _imagelink = details.profileImg!;
      print(_imagelink);
    });
  } */

/*   _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    File profileImage = File(image!.path);
     
    ApiCaller().fileUploader("profileimage", profileImage, "jpeg");
    GetProfileDetails details = await ApiCaller().ProfileDetails();
    setState(() {
      _image = image;
      _imagelink = details.profileImg!;

      print(_imagelink);
    });
  } */
  Future<void> loadimage() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    setState(() {
      _imagelink = SharedPrefrences.getString('profilepic')!;
    });
  }

  File? _image;
  String? filename;
  String? extension;
  Uint8List? imageinbytes;
  Future uploadImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(
      source: source,
      imageQuality: source == ImageSource.camera ? 40 : 70,
    );
    File file = File(image!.path);
    final bytes = file.readAsBytesSync().lengthInBytes;
    final kb = bytes / 1024;
    final imagebytes = await file.readAsBytes();
    GetProfileDetails details = await ApiCaller().ProfileDetails();

    setState(() {
      _imagelink = details.profileImg!;

      print(kb);
      filename = path.basename(file.path).split("/").last;
      _image = (file);
      extension = filename!.split(".").last;

      imageinbytes = imagebytes;
      // print(imagebytes) ;
    });
    var stringfordata =
        await ApiCaller().fileUploader(filename!, _image!, extension!);
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();
    SharedPrefrences.setString(
      'profilepic',
      stringfordata['url'],
    );
    setState(() {
      loadimage();
    });
  }

  @override
  void initState() {
    LoadDetails();
    loadimage();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 200,
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
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'My Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 44,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(_imagelink),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showPicker(context);
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        color: Colors.green,
                                      ),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height - 160,
                color: Color(0XffF8F8F8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Alert(
                            context: context,
                            title: "Name",
                            content: TextField(
                              onChanged: (value) {
                                setState(() {
                                  userName = value;
                                });
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.account_circle),
                                labelText: 'Username',
                              ),
                            ),
                            buttons: [
                              DialogButton(
                                color: Color(0Xff4C6EE5),
                                onPressed: () async {
                                  /*  ApiCaller().UserProfile(userName, userEmail,
                                      birthDateInString, 'male'); */
                                  var res1 = await post(
                                    Uri.parse(
                                        'http://api.siren24.xyz/api/profile/edit'),
                                    headers: {
                                      HttpHeaders.contentTypeHeader:
                                          'application/json',
                                      "authtoken": authToken,
                                    },
                                    body: jsonEncode({"name": userName}),
                                  );
                                  Logger().d(res1.body);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Update Username",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ]).show();
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
                              'Name',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '$userName',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
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
                        Alert(
                            context: context,
                            title: "Email",
                            content: TextField(
                              onChanged: (value) {
                                setState(() {
                                  userEmail = value;
                                });
                              },
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                labelText: 'email',
                              ),
                            ),
                            buttons: [
                              DialogButton(
                                color: Color(0Xff4C6EE5),
                                onPressed: () async {
                                  /*   ApiCaller().UserProfile(userName, userEmail,
                                      birthDateInString, 'male'); */
                                  var res2 = await post(
                                    Uri.parse(
                                        'http://api.siren24.xyz/api/profile/edit'),
                                    headers: {
                                      HttpHeaders.contentTypeHeader:
                                          'application/json',
                                      "authtoken": authToken,
                                    },
                                    body: jsonEncode({"address": userEmail}),
                                  );
                                  Logger().d(res2.body);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Update Email",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ]).show();
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
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              '$userEmail',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
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
                              'Gender',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Container(
                              child: DropdownButton(
                                  value: _value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        "Male",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text(
                                        "Female",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                        child: Text(
                                          "Other",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        value: 3),
                                  ],
                                  onChanged: (value) {
                                    setState(() async {
                                      _value = value;
                                      if (_value == 1) {
                                        var res4 = await post(
                                          Uri.parse(
                                              'http://api.siren24.xyz/api/profile/edit'),
                                          headers: {
                                            HttpHeaders.contentTypeHeader:
                                                'application/json',
                                            "authtoken": authToken,
                                          },
                                          body: jsonEncode({"gender": 'male'}),
                                        );
                                        Logger().d(res4.body);
                                      } else if (_value == 2) {
                                        var res4 = await post(
                                          Uri.parse(
                                              'http://65.2.132.175:4000/api/profile/edit'),
                                          headers: {
                                            HttpHeaders.contentTypeHeader:
                                                'application/json',
                                            "authtoken": authToken,
                                          },
                                          body:
                                              jsonEncode({"gender": 'female'}),
                                        );
                                        Logger().d(res4.body);
                                      } else {
                                        var res4 = await post(
                                          Uri.parse(
                                              'http://api.siren24.xyz/api/profile/edit'),
                                          headers: {
                                            HttpHeaders.contentTypeHeader:
                                                'application/json',
                                            "authtoken": authToken,
                                          },
                                          body: jsonEncode({"gender": 'other'}),
                                        );
                                        Logger().d(res4.body);
                                      }
                                    });
                                    print(_value.toString());
                                  }),
                            ),
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
                      onTap: () async {
                        final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.now(),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100));
                        if (datePick != null && datePick != birthDate) {
                          setState(() {
                            birthDate = datePick;

                            birthDateInString =
                                "${birthDate.year}/${birthDate.month}/${birthDate.day}"; // 08/14/2019
                          });
                          /*   ApiCaller().UserProfile(
                              userName, userEmail, birthDateInString, 'male'); */
                          var res3 = await post(
                            Uri.parse(
                                'http://api.siren24.xyz/api/profile/edit'),
                            headers: {
                              HttpHeaders.contentTypeHeader: 'application/json',
                              "authtoken": authToken,
                            },
                            body: jsonEncode({"dob": birthDateInString}),
                          );
                          Logger().d(res3.body);
                        }
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
                              'Birthday',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              birthDateInString.substring(0, 8),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
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
                        print(birthDateInString);
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
                              'Phone number',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Text(
                              Phone.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                            Icon(Icons.chevron_right),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library '),
                      onTap: () {
                        uploadImage(ImageSource.gallery);

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      uploadImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
