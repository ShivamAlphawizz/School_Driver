import 'dart:async';
import 'package:flutter/material.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterdrawer_Screen.dart';
import 'package:job_dekho_app/Views/signin_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Job Seeker/seekermyprofile_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    //Timer(Duration(seconds: 5), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));});
    super.initState();
    // Future.delayed(Duration(milliseconds: 300),(){
    //   return checkLogin();
    // });

    Future.delayed(Duration(milliseconds: 1500),(){
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowGif()));
      // if(userid == null || userid == ""){
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
      // }
      // else{
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // }
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   //Timer(Duration(seconds: 5), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));});
  //   super.initState();
  //   Future.delayed(Duration(milliseconds: 300),(){
  //     return checkLogin();
  //   });
  //
  //   Future.delayed(Duration(seconds: 2),(){
  //     if(userid == null || userid == ""){
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
  //     }
  //     else{
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SeekerProfileDetailScreen()));
  //     }
  //   });
  // }
  //
  // String? userid;
  // void checkLogin()async{
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   userid = pref.getString('user_id');
  // }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image:AssetImage('assets/splashscreen.png'),
            fit: BoxFit.fill
            )
          )
        ),
      ),
    );
  }
}


class ShowGif extends StatefulWidget {
  const ShowGif({Key? key}) : super(key: key);

  @override
  State<ShowGif> createState() => _ShowGifState();
}

class _ShowGifState extends State<ShowGif> {
  @override
  void initState() {
    // TODO: implement initState
    //Timer(Duration(seconds: 5), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));});
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      return checkLogin();
    });

    Future.delayed(Duration(seconds: 3),(){
      if(userid == null || userid == ""){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SeekerProfileDetailScreen()));
      }
    });
  }

  String? userid;
  void checkLogin()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    userid = pref.getString('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
            image: DecorationImage(
                image: AssetImage(
                  'assets/handShake.gif',
                ),
                fit: BoxFit.cover
            )
        ),
      ),
    ));
  }
}