import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Model/notificationModel.dart';
import 'package:job_dekho_app/Utils/Api_path.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customNotificaitonTile.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterdrawer_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/style.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  
  NotificationModel? notificationModel;
  
  getNotification()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=fb25b07efa6525033b72e9f9c85373569f558dd8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}notification_list'));
    request.fields.addAll({
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalRseult = await response.stream.bytesToString();
      final jsonResponse = NotificationModel.fromJson(json.decode(finalRseult));
      setState(() {
        notificationModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getNotification();
    });
  }

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
                  Expanded(child:
                  notificationModel == null ? Center(child: CircularProgressIndicator(),) : notificationModel!.notifications!.length == 0 ? Center(child: Text("No Notification to show"),) :
                  ListView.builder(
                    shrinkWrap: true,
                      itemCount: notificationModel!.notifications!.length,
                      itemBuilder: (c,i){
                    return CustomNotificaitonTile(username: "${notificationModel!.notifications![i].title}", time: "${notificationModel!.notifications![i].date}",description: "${notificationModel!.notifications![i].message}",);
                  }))
                  // CustomNotificaitonTile(username: "Vikas Agrawal", time: '5min ago'),

                ],
              ),
            ),
          )
        ));;
  }
}
