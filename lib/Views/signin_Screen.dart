import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/email_Tab.dart';
import 'package:job_dekho_app/Utils/style.dart';
import 'package:job_dekho_app/Views/forgotpassword_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Api_path.dart';
import '../Utils/CustomWidgets/customTextButton.dart';
import '../Utils/CustomWidgets/mobile_Tab.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Job Seeker/seekermyprofile_Screen.dart';
import 'Recruiter/recruitermyprofile_Screen.dart';
import 'signup_Screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  String? token;

  getToken() async {
    print("working this here");
    var fcmToken = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = fcmToken.toString();
    });
    print("FCM ID Is  driver$token");
  }
  bool loader = false;

  driverLogin() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    print("Login Api Is Working");
    var headers = {
      'Cookie': 'ci_session=1ce8eda44fa0405bd1218dde8a83405a1c4260b3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}driver_login'));
    request.fields.addAll({
      'email': '${emailCtr.text.toString()}',
      'password': '${passwordCtr.text.toString()}',
      'fcm_id':"${token}"
    });
    print("Checking all fields here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("Working Nowwww ${jsonResponse}");
      if(jsonResponse['status'] == 'success'){
        String user_id = jsonResponse['user_id']['id'];
        prefs.setString('user_id', user_id.toString());
        print("User Id here ${user_id.toString()}");
        // Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        setState(() {
          print("final response>>>>> ${jsonResponse['message']}");
          var snackBar = SnackBar(
            content: Text('${jsonResponse['message']}'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          loader = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SeekerProfileDetailScreen()));
      }
      else{
        setState(() {
          loader = false;
        });
        var snackBar = SnackBar(
          content: Text('${jsonResponse['message']}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    }
    else {
    }
  }

  bool showPassword = false;

  var _value = 0;
  bool isEmail = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea
      (child: Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Image.asset('assets/jobdekho_logo.png', scale: 1.5,),
              ),
              Container(
                padding: EdgeInsets.all(14),
                width: size.width,
                height: size.height / 1.1,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('LogIn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Serif'),
                    ),
                    SizedBox(height: 25,),
                    Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 48,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Valid Email';
                              }
                              return null;
                            },
                            controller: emailCtr,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                hintText: "Enter Email",
                              prefixIcon: Icon(Icons.email, color: primaryColor)
                            ),
                          ),
                        )),
                    SizedBox(height: 25,),
                    Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 48,
                          child: TextFormField(
                            obscureText: showPassword == true  ? false: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter Valid Password';
                              }
                              return null;
                            },
                            controller: passwordCtr,

                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                  onTap: (){
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: showPassword == true  ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                hintText: "Enter Password",
                                prefixIcon: Icon(Icons.lock, color: primaryColor),
                            ),
                          ),
                        )),
                    SizedBox(height: 10,),
                    // GestureDetector(
                    //   onTap: (){
                    //     Get.to(ForgotPasswordScreen());
                    //   },
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(horizontal: 20),
                    //     child: Align(
                    //         alignment: Alignment.centerRight,
                    //         child: Text('Forgot Password?', style: TextStyle(color: greyColor1,fontWeight: FontWeight.bold,),)),
                    //   ),
                    // ),
                    SizedBox(height: 80,),
                    // CustomTextButton(buttonText: 'Sign In', onTap: (){
                    //   driverLogin();
                    //
                    // }),
                    InkWell(
                      onTap: (){
                        setState(() {
                          loader = true;
                        });
                        driverLogin();
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/1.5,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: loader == true ? CircularProgressIndicator(color: Colors.white,) :
                        Text("Sign in",style: TextStyle(fontFamily: 'Serif',color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
                      ),
                    ),
                    // Column(children: [isEmail ? EmailTabs() : MobileTabs()]),
                    // SizedBox(height: 80,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text("Don't have an account? ", style: TextStyle(color: greyColor,fontWeight: FontWeight.bold),),
                    //     GestureDetector(onTap: (){Get.to(SignUpScreen());},child: Text("Sign Up", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),))
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ));
  }
}
