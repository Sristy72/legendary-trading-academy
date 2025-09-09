import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool signalAlerts = true;
  bool eventReminders = false;
  bool promoAnnouncements = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notification Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Signal alerts from specific coaches only"),
              value: signalAlerts,
              activeColor: Colors.amber, // yellow
              onChanged: (value) {
                setState(() {
                  signalAlerts = value;
                });
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Event/class reminders"),
              value: eventReminders,
              activeColor: Colors.amber,
              onChanged: (value) {
                setState(() {
                  eventReminders = value;
                });
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Promo/discounts or announcements"),
              value: promoAnnouncements,
              activeColor: Colors.amber,
              onChanged: (value) {
                setState(() {
                  promoAnnouncements = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
