import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customNotificaitonTile.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterdrawer_Screen.dart';

import '../Utils/style.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: primaryColor,
              leading: GestureDetector(
                onTap: (){
                  Get.to(DrawerScreen());
                },
                child: Icon(Icons.arrow_back_ios, color: whiteColor, size: 20),
                //Icon(Icons.arrow_back_ios, color: whiteColor, size: 22),
              ),
              title:  Text('Notification', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Serif'),),
            ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(90)),
                  color: Colors.white
              ),
              alignment: Alignment.center,
              width: size.width,
              height: size.height,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  CustomNotificaitonTile(username: "Vikas Agrawal", time: '5min ago'),
                  CustomNotificaitonTile(username: "Bob John", time: '15min ago'),
                  CustomNotificaitonTile(username: "Niraj Vyas", time: '1hr ago'),
                  CustomNotificaitonTile(username: "Lalit Pandit", time: '15hr ago'),
                  CustomNotificaitonTile(username: "Babu Sharma", time: '1d ago'),

                ],
              ),
            ),
          )
        ));;
  }
}
