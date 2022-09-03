import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:siren24/basescreen/home_screen.dart';
import 'package:siren24/basescreen/rating.dart';

import 'package:siren24/onbording/OnboardingScreens.dart';
import 'package:siren24/onbording/setup_gps_screen.dart';
import 'package:siren24/onbording/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:siren24/payments/payment.dart';
import 'package:siren24/profile/history.dart';
import 'package:siren24/profile/inviteFriends.dart';
import 'package:siren24/profile/my_profile.dart';
import 'package:siren24/profile/notification.dart';
import 'package:siren24/profile/settings.dart';
import 'package:siren24/Sheets/date_picker.dart';
import 'package:siren24/signup/signin.dart';
import 'package:siren24/signup/verifcation.dart';
import 'package:logger/logger.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:siren24/Models/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:siren24/my-globals.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // final PendingDynamicLinkData? initialLink =
  //     await FirebaseDynamicLinks.instance.getInitialLink();
  // final SharedPreferences pref = await SharedPreferences.getInstance();
  // AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //       channelKey: 'notif_channel',
  //       channelName: 'Notification Channel',
  //       channelDescription: 'Notification Body',
  //       importance: NotificationImportance.High,
  //       channelShowBadge: true,
  //       ledOnMs: 3000,
  //       enableVibration: true,
  //       playSound: true,
  //       defaultRingtoneType: DefaultRingtoneType.Ringtone,
  //     ),
  //   ],
  // );
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(MyApp(
   // initialLink: initialLink,
  ));
}

List? data;
String? page;
late FirebaseMessaging _messaging;
void getMessage() async {
  await Firebase.initializeApp();
  _messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    FirebaseMessaging.onMessage.listen((event) {
      savenotif(event);
      Logger().d('foreground');
      normalNotification(event.data['title'], event.data['body']);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      savenotif(event);
      Logger().d('background');
      normalNotification(event.data['title'], event.data['body']);
    });
    _terminated();
  }
}

Future<void> _terminated() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    savenotif(initialMessage);
    Logger().d('getinitil');
    normalNotification(
        initialMessage.data['title'], initialMessage.data['body']);
    AwesomeNotifications().actionStream.listen((event) {
      Logger().d(event.channelKey);
      Logger().d(data);
    });
  }
}

void savenotif(RemoteMessage event) async {
  Logger().d('received message');
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String type = event.data['type'] == null ? 'null' : event.data['type'];
  String body = event.data['body'] == null ? 'null' : event.data['body'];
  String title = event.data['title'] == null ? 'null' : event.data['title'];
  bookingSuccessful = event.data['response'];
  paymentDone = event.data['payment'];
  String img_url =
      event.data['img_url'] == null ? 'null' : event.data['img_url'];
  String drop_latitude = event.data['drop_latitude'] == null
      ? 'null'
      : event.data['drop_latitude'];
  String drop_longitude = event.data['drop_longitude'] == null
      ? 'null'
      : event.data['drop_longitude'];
  String pickup_latitude = event.data['pickup_latitude'] == null
      ? 'null'
      : event.data['pickup_latitude'];
  String pickup_longitude = event.data['pickup_longitude'] == null
      ? 'null'
      : event.data['pickup_longitude'];
  String phone = event.data['phone'] == null ? 'null' : event.data['phone'];
  String payment =
      event.data['payment'] == null ? 'null' : event.data['payment'];
  String discount =
      event.data['discount'] == null ? 'null' : event.data['discount'];
  String orderID =
      event.data['orderid'] == null ? 'null' : event.data['orderid'];
  String temp_add =
      event.data['addons'] == null ? 'null' : event.data['addons'];
  String addons = '';
  for (int i = 1; i < temp_add.length - 1; i++) {
    if (temp_add[i] != "\"") {
      addons = addons + temp_add[i];
    }
  }
  Logger().d(addons);
  // List addons_final = addons.split(',');
  // Logger().d(addons_final);
  String notif = type +
      "~" +
      body +
      "~" +
      title +
      "~" +
      img_url +
      "~" +
      drop_latitude +
      "~" +
      drop_longitude +
      "~" +
      pickup_latitude +
      "~" +
      pickup_longitude +
      "~" +
      phone +
      "~" +
      payment +
      "~" +
      discount +
      "~" +
      orderID +
      "~" +
      addons;
  Logger().d(notif);
  List<String>? notifications =
      preferences.getStringList('notifications') == null
          ? []
          : preferences.getStringList('notifications');
  if (notifications!.length > 14) {
    notifications.removeAt(0);
  }
  notifications.add(notif);
  preferences.setStringList('notifications', notifications);
  List<String> passing = notif.split('~');
  Logger().d(passing);
  data = passing;
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message");
  Logger().d(message.data);
  // Get.toNamed(Notifications.id);
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'notif_channel',
        title: message.data["title"],
        body: message.data["body"],
        displayOnBackground: true,
        displayOnForeground: true,
        largeIcon: 'asset://icons/card.png',
        bigPicture:
            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
        notificationLayout: NotificationLayout.BigPicture,
        wakeUpScreen: true,
        color: Color(0xFFFFD428),
      ),
      actionButtons: []);
  Logger().d('done');
  getMessage();
}

class MyApp extends StatefulWidget {
  PendingDynamicLinkData? initialLink;
  MyApp({Key? key, this.initialLink}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> normalNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: 'notif_channel',
          title: title,
          body: body,
          displayOnBackground: true,
          displayOnForeground: true,
          largeIcon: 'asset://icons/card.png',
          bigPicture:
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
          notificationLayout: NotificationLayout.BigPicture,
          wakeUpScreen: true,
          color: Color(0xFFFFD428),
        ),
        actionButtons: []);
  }

  void getMessage() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onMessage.listen((event) {
      savenotif(event);
      Logger().d('foreground');
      normalNotification(event.data['title'], event.data['body']);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      savenotif(event);
      Logger().d('background');
      normalNotification(event.data['title'], event.data['body']);
    });
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      savenotif(initialMessage);
      Logger().d('getinitil');
      normalNotification(
          initialMessage.data['title'], initialMessage.data['body']);
    }
    if (paymentDone) {
      Navigator.pushNamed(context, PaymentPage.id);
    }
  }

  //Notification List order = [type, body, title, img_uri, drop_latitude, drop_longitude, pickup_latitude, pickup_longitude, phone, payment, discount, orderID, addons]

  void savenotif(RemoteMessage event) async {
    Logger().d('received message');
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String type = event.data['type'] == null ? 'null' : event.data['type'];
    String body = event.data['body'] == null ? 'null' : event.data['body'];
    String title = event.data['title'] == null ? 'null' : event.data['title'];
    setState(() {
      bookingSuccessful = event.data['response'];
      paymentDone = event.data['payment'];
    });
    if (paymentDone) {
      Navigator.pushNamed(context, PaymentPage.id);
    }
    String img_url =
        event.data['img_url'] == null ? 'null' : event.data['img_url'];
    String drop_latitude = event.data['drop_latitude'] == null
        ? 'null'
        : event.data['drop_latitude'];
    String drop_longitude = event.data['drop_longitude'] == null
        ? 'null'
        : event.data['drop_longitude'];
    String pickup_latitude = event.data['pickup_latitude'] == null
        ? 'null'
        : event.data['pickup_latitude'];
    String pickup_longitude = event.data['pickup_longitude'] == null
        ? 'null'
        : event.data['pickup_longitude'];
    String phone = event.data['phone'] == null ? 'null' : event.data['phone'];
    String payment =
        event.data['payment'] == null ? 'null' : event.data['payment'];
    String discount =
        event.data['discount'] == null ? 'null' : event.data['discount'];
    String orderID =
        event.data['orderid'] == null ? 'null' : event.data['orderid'];
    String temp_add =
        event.data['addons'] == null ? 'null' : event.data['addons'];
    String addons = '';
    for (int i = 1; i < temp_add.length - 1; i++) {
      if (temp_add[i] != "\"") {
        addons = addons + temp_add[i];
      }
    }
    Logger().d(addons);
    // List addons_final = addons.split(',');
    // Logger().d(addons_final);
    String notif = type +
        "~" +
        body +
        "~" +
        title +
        "~" +
        img_url +
        "~" +
        drop_latitude +
        "~" +
        drop_longitude +
        "~" +
        pickup_latitude +
        "~" +
        pickup_longitude +
        "~" +
        phone +
        "~" +
        payment +
        "~" +
        discount +
        "~" +
        orderID +
        "~" +
        addons;
    Logger().d(notif);
    List<String>? notifications =
        preferences.getStringList('notifications') == null
            ? []
            : preferences.getStringList('notifications');
    if (notifications!.length > 14) {
      notifications.removeAt(0);
    }
    notifications.add(notif);
    preferences.setStringList('notifications', notifications);
    List<String> passing = notif.split('~');
    Logger().d(passing);
    setState(() {
      data = passing;
    });
  }

  @override
  void initState() {
    super.initState();
    getMessage();
    AwesomeNotifications().actionStream.listen((event) {
      Logger().d(event.channelKey);
      Logger().d(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Splash_Screen(),
          routes: {
            HomeScreen.id: (context) => const HomeScreen(),
            OnboardingScreens.id: (context) => const OnboardingScreens(),
            Sign_in.id: (context) => const Sign_in(),
            OtpVerification.id: (context) => const OtpVerification(),
            setup_gps_screen.id: (context) => const setup_gps_screen(),
            Settings.id: (context) => const Settings(),
            MyProfile.id: (context) => const MyProfile(),
            Notifications.id: (context) => const Notifications(),
            History.id: (context) => const History(),
            Splash_Screen.id: (context) => Splash_Screen(),
            RatingScreen.id: (context) => RatingScreen(),
            PaymentPage.id: (context) => PaymentPage(),
            InviteFriends.id: (context) => InviteFriends(),
            Date_select.id: (context) => Date_select(),
          },
        ),
      ),
    );
  }
}
