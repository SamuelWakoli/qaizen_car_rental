import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _noNotification = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _noNotification
          ? Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Icon(
                  Icons.notifications_off_outlined,
                  size: 120,
                ),
                Text('You have no notifications')
              ],
            )
          : Text('null'),
    );
  }
}
