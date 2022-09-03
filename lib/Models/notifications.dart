import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> normalNotification(String title, String body) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
      channelKey: 'normal_notif',
      title: title,
      body: body,
      displayOnBackground: true,
      displayOnForeground: true,
      largeIcon: 'asset://icons/card.png',
      bigPicture:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
