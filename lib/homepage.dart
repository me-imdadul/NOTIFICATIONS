

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/smscontroller.dart';
import 'package:notification_listener_service/notification_listener_service.dart';

import 'smscontroller.dart';

class homepage extends StatelessWidget{
  const homepage({super.key});

  @override
  Widget build(BuildContext context)
  { SMSController smsController = Get.put(SMSController()
  return Scaffold(
    appBar: AppBar(
      title:Text('Notification Reader'),
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

          Obx(
              ()=> Column(children:smsController.notificationList
                  .map(
                    (event)=>
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                color:Colors.black,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                children: [
                                  Row(
                                    children: [
      
                                     // Text(event.toString()),
                                      Text(event.toString(),style: TextStyle(color: Colors.white70),),
      
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
                            ],
                          ),
                        )
              )
                  .toList(),
              )
          )
        ],
      
      ),
    ),
  );
  }
}