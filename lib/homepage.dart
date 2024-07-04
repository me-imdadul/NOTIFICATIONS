import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/smscontroller.dart';
import 'package:notification_listener_service/notification_listener_service.dart';

import 'smscontroller.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  SMSController smsController = Get.put(SMSController());
  @override
  void initState() {
     smsController.loadNotificationList();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Reader'),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                smsController.requestForPermission();
              },
              child: Text('Button'),
            ),
            Obx(() => Column(
                  children: smsController.mapEvent
                      .map((event) => SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Expanded(
                              flex: 6,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      color: Colors.black,
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              // Text(event.toString()),
                                              Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    event['title'],
                                                    style: TextStyle(
                                                        color: Colors.white70),
                                                  )),
                                              Expanded(
                                                  flex: 6,
                                                  child: Text(
                                                    event['content'],
                                                    style: TextStyle(
                                                        color: Colors.white70),
                                                  )),
                                            ],
                                          ),
                                          //   Row(
                                          //   children: [
                                          //   Text(event.title)
                                          //],
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ))
          ],
        ),
      ),
    );
  }
}
