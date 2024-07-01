
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:get/get.dart';
import 'package:notification_listener_service/notification_event.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
get notificationList => null;

class SMSController extends GetxController {

  RxList notificationList = RxList<ServiceNotificationEvent>();

  @override
  void onInit() {
    // TODO: implement $configureLifeCycle
    super.onInit();
    listenNotification();
  }

  void requestForPermission() async {
    print("requesting perm");
    final bool status = await NotificationListenerService.isPermissionGranted();
    if (status != true) {
      print("no permission");
      final bool statuss =
      await NotificationListenerService.requestPermission();
    }
    listenNotification();
  }


  void listenNotification() {
    print("Listening for notifications...");

    NotificationListenerService.notificationsStream.listen((event) {
      print("Current notification: $event");

      if (event.packageName == "com.whatsapp") {
        notificationList.add(event);
      }
    });
  }
}