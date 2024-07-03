import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notification_listener_service/notification_event.dart';
import 'package:notification_listener_service/notification_listener_service.dart';

class SMSController extends GetxController {
  var notificationList = <ServiceNotificationEvent>[].obs;

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
    listenNotification();
  }

  void listenNotification() {
    print("Listening for notifications...");

    NotificationListenerService.notificationsStream.listen((event) {
      print("Current notification: $event");

      if (event.packageName == "com.whatsapp") {
        if (!notificationList.any((e) => e.id == event.id && e.content == event.content)) {
          notificationList.add(event);
        }
      }
    });
  }
}
