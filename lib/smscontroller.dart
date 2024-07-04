import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:notification_listener_service/notification_event.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SMSController extends GetxController {
  var notificationList = <ServiceNotificationEvent>[].obs;
  List<Map<String,dynamic>> mapEvent = <Map<String,dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenNotification();
  }

  void requestForPermission() async {
    print("requesting permission");
    final bool status = await NotificationListenerService.isPermissionGranted();
    if (!status) {
      print("no permission");
      await NotificationListenerService.requestPermission();
    }
  }

  void listenNotification() {
    print("Listening for notifications...");

    NotificationListenerService.notificationsStream.listen((event) {
      print("Current notification: $event");

      if (event.packageName == "com.whatsapp") {
        if (!notificationList.any((e) => e.id == event.id && e.content == event.content)) {
          mapEvent.add({
            'title' : event.title,
            'content' : event.content
          });
          //save or store messages to cloud
          saveNotificationList();
        }
      }
    });
  }

  void saveNotificationList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> encodedList = mapEvent.map((e) => e.toString()).toList();
    await prefs.setStringList('notificationList', encodedList);
  }

  void loadNotificationList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? encodedList = prefs.getStringList('notificationList');
    if (encodedList != null) {
      mapEvent.addAll(encodedList.map((e) => json.decode(e)));
    }
  }
  
}