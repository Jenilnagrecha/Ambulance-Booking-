// ignore_for_file: unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class InviteFriends extends StatefulWidget {
  InviteFriends({Key? key}) : super(key: key);
  static String id = 'invite_friends';
  @override
  _InviteFriendsState createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  late Uri uri;
  String referral_code = "0905070017";
  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future<void> buildlink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // The Dynamic Link URI domain. You can view created URIs on your Firebase console
      uriPrefix: 'https://example',
      // The deep Link passed to your application which you can use to affect change
      link: Uri.parse('https://www.example.com/view-to-open'),
      // Android application details needed for opening correct app on device/Play Store
      androidParameters: const AndroidParameters(
        packageName: 'com.example.siren24',
        minimumVersion: 1,
      ),
      // iOS application details needed for opening correct app on device/App Store
      // iosParameters: const IOSParameters(
      //   bundleId: iosBundleId,
      //   minimumVersion: '2',
      // ),
    );

    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    uri = shortDynamicLink.shortUrl;
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: referral_code)).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[100],
          duration: Duration(milliseconds: 1000),
          elevation: 5,
          margin: EdgeInsets.only(
            bottom: 75.h,
            left: 115.w,
            right: 115.w,
            top: 675.h,
          ),
          behavior: SnackBarBehavior.floating,
          content: Center(
            child: Text(
              'Copied to clipboard',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0Xff4C6EE5)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Invite Friends',
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 240.h,
                        child: Container(
                          width: 180.w,
                          height: 180.w,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(150),
                          ),
                          child: Align(
                            child: Image.asset(
                              'UIAssets/teamwork.png',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.h,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 35.w, right: 35.w),
                        child: Center(
                          child: Text(
                            'Invite Friends',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.sp,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35.w, right: 35.w),
                        child: Center(
                          child: Text(
                            'Earn up to ₹150 a day',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 49.w, right: 49.w),
                    child: Center(
                      child: Container(
                        child: Text(
                          'When your friend sign up with your referral code, you can receive up to ₹150 a day.',
                          style: TextStyle(
                            fontSize: 17.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        Text(
                          'SHARE YOUR INVITE CODE',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(0xFFBEC2CE),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (referral_code != null) {
                        _copyToClipboard();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('NO INVITE CODE'),
                            // backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 305.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F2F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          referral_code == null
                              ? " "
                              :
                              // invitecode,
                              referral_code,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (referral_code != null) {
                        //Share.share(uri.toString());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('NO INVITE CODE'),
                            // backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 305.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD428),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'INVITE',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
