import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:siren24/Models/PushNotification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  static String id = 'notifications';
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late int _totalnotificationCounter;
  void registerNotification() async {
    await Firebase.initializeApp();
  }

  List<List> _notifications = [];
  Future getnotification() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? temp = pref.getStringList('notifications');
    Logger().d(temp);
    List<List>? nots = [];
    int _len = temp!.length;
    for (int i = 0; i < _len; i++) {
      final tolist = temp[i].split('~');
      nots.add(tolist);
    }
    setState(() {
      _notifications = nots;
      _totalnotificationCounter = temp.length;
    });
  }

  @override
  void initState() {
    super.initState();
    getnotification();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 160,
            width: width,
            color: Color.fromARGB(255, 76, 110, 229),
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
                    'Notifications',
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
            child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 0.88 * height,
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 0,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 0.15 * width,
                                  top: 0.20 * height,
                                  bottom: 0.20 * height,
                                  right: 0.2 * width),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4252FF),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF4252FF),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            'UIAssets/tick.png',
                                            color: Colors.white,
                                            scale: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.19 * height,
                                  bottom: 0.19 * height,
                                  left: 0.10 * width,
                                  right: 0.2 * width),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _notifications[
                                        _notifications.length - 1 - index][2],
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    height: 20 * height,
                                    width: 0.8 * width,
                                    child: Text(
                                      _notifications[
                                          _notifications.length - 1 - index][1],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
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
                }),
          )
        ],
      ),
    );
  }
}
