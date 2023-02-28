import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customDrawerTile.dart';
import 'package:job_dekho_app/Utils/style.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Views/Job%20Seeker/seekermyprofile_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/appliedjobs_Screens.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterprofiledetails_Screen.dart';
import 'package:job_dekho_app/Views/changepassword_Screen.dart';
import 'package:job_dekho_app/Views/contactus_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/recruitermyprofile_Screen.dart';
import 'package:job_dekho_app/Views/driverStatus.dart';
import 'package:job_dekho_app/Views/notification_Screen.dart';
import 'package:job_dekho_app/Views/signin_Screen.dart';
import 'package:job_dekho_app/Views/updatejobpost_Screen.dart';
import 'package:job_dekho_app/Views/privacypolicy_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/searchcandidate_Screen.dart';
import 'package:job_dekho_app/Views/termsandcondition_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/postJob_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/iconUrl.dart';
import '../driverFeedback.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Share',
        // text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }

  openLogoutDialog(){
    return showDialog(context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          title: Text("Are you sure want to logout app ?",style: TextStyle(fontFamily: 'Serif', color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                  prefs.setString('user_id', "");
                  setState((){

                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  child:  Text("Confirm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14, fontFamily: 'Serif'),),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.red,
                  ),
                  child:  Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14, fontFamily: 'Serif'),),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App', style: TextStyle(fontFamily: 'Serif'),),
        content: Text('Do you want to exit an App?', style: TextStyle(fontFamily: 'Serif')),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No', style: TextStyle(fontFamily: 'Serif')),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: (){
              exit(0);
              // Navigator.pop(context,true);
              // Navigator.pop(context,true);
            },
            //return true when click on "Yes"
            child:Text('Yes', style: TextStyle(fontFamily: 'Serif'),),
          ),
        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 100,
              color: primaryColor,
              child: Image.asset('assets/jobdekho_logo.png', scale: 2,),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: size.width,
              height: size.height / 1.1,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  CustomDrawerTile(tileName: 'Student Details', tileIcon: Image.asset(profileIconR, scale: 1.3,),onTap: (){
                    Get.to(SeekerProfileDetailScreen());},),
                  CustomDrawerTile(tileName: 'Driver Profile', tileIcon: Image.asset(profileIconR, scale: 1.3,),onTap: (){
                    Get.to(RecruiterMyProfileScreen());},),
                  // CustomDrawerTile(tileName: 'Change Password', tileIcon: Image.asset(changepasswordIconR, scale: 1.3,), onTap: (){
                  //   Get.to(ChangePasswordScreen());},),
                  CustomDrawerTile(tileName: 'Share App', tileIcon: Image.asset(shareappIconR, scale: 1.3,),onTap: (){Get.to(share());},),
                  CustomDrawerTile(tileName: 'Driver Feedback', tileIcon: Image.asset(searchIconR,color: primaryColor,scale: 1.3,),onTap: (){
                    Get.to(DriveFeedback());},),
                  CustomDrawerTile(tileName: 'Driver Status', tileIcon: Image.asset(notificationIconR, scale: 1.3,),onTap: (){
                    Get.to(DriverStatus());}),
                  // CustomDrawerTile(tileName: 'Contact Us', tileIcon: Image.asset(contactusIconR, scale: 1.3,), onTap: (){
                  //   Get.to(ContactUsScreen());},),
                  CustomDrawerTile(tileName: 'Privacy Policy', tileIcon: Image.asset(privactpolicyIconR, scale: 1.3,), onTap: (){
                    Get.to(PrivacyPolicyScreen());},),
                  CustomDrawerTile(tileName: 'Terms & Conditions', tileIcon: Image.asset(termsandconditionIconR, scale: 1.3,),onTap: (){
                    Get.to(TermsAndConditionScreen());},),
                  CustomDrawerTile(tileName: 'Sign Out', tileIcon: Image.asset(signoutIconR, scale: 1.3,),onTap: (){
                    openLogoutDialog();
                  },),
                  // CustomDrawerTile(tileName: 'Post Job', tileIcon: Image.asset(postjobIconR, scale: 1.3,),onTap: (){Get.to(PostJobScreen());}),
                  // CustomDrawerTile(tileName: 'Applied Jobs', tileIcon: Image.asset(appliedIconR, scale: 1.3,),onTap: (){Get.to(AppliedJobsScreen());},),
                ],
              ),
            )
          ],
        ),
      )
    ));
  }
}
