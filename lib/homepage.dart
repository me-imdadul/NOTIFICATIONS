import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/smscontroller.dart';

class homepage extends StatelessWidget{
  const homepage({super.key});

  @override
  Widget build(BuildContext context)
  { SMSController smsController = Get.put(SMSController());
    return Scaffold(
      appBar: AppBar(
        title:Text('Notification Reader'),
        backgroundColor: Colors.purple,
    ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              smsController.requestForPermission();
            },
            child: Text('Button'),
          )

        ],
      ),
    );
  }
}