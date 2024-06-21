import 'package:get/get.dart';
import 'package:notification_listener_service/notification_listener_service.dart';
class SMSController extends GetxController {
  void requestForPermission()async {
    final bool status = await NotificationListenerService.isPermissionGranted();
    if (status != true) {
      print("NO permission");
      final bool status = await NotificationListenerService.requestPermission();
     return;
    }
    listenNotification();
  }
    void listenNotification(){
      NotificationListenerService.notificationsStream.listen((event)
          {
            print("Current Notification:$event");
    });
    }

  }
