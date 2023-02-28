import 'package:flutter/material.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/jobseeker_Tab.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/recruiter_Tab.dart';
import '../Utils/style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea
      (child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 5.5 ,
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Image.asset('assets/jobdekho_logo.png', scale: 1.5,),
                ),
                Container(
                  padding: EdgeInsets.all(14),
                  width: size.width,
                  height: size.height /1.25,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(70))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
                      SizedBox(height: 10,),
                      TabBar(
                          labelColor: primaryColor,
                          unselectedLabelColor: Colors.grey,
                          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(width: 4.5, color: primaryColor)
                          ),
                          indicatorColor: primaryColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: [Tab(text: "Job Seeker",), Tab(text: "Recruiter",),]),
                      SizedBox(height: 12,),
                      SizedBox(height: MediaQuery.of(context).size.height / 1.65,
                        child: TabBarView(
                            children: [
                              JobSeekerTab(),
                              RecruiterTab()
                            ]),)
                    ],
                  ),
                ),
              ],
            ),
          )
    ),
      ));
  }
}
