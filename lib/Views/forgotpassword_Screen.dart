import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customTextButton.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextFormField.dart';
import '../Utils/style.dart';
import 'signin_Screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        //centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: (){
            Get.to(SignInScreen());
          },
          child: Icon(Icons.arrow_back_ios, color: primaryColor, size: 26),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 250,
              height: 300,
              child: Image.asset('assets/AuthAssets/forgotpassword.png'),
            ),
            SizedBox(height: 25,),
            Text("Forget Password?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Serif'),),
            SizedBox(height: 20,),
            Text('Enter email associated \n with your account', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: greyColor1, fontFamily: 'Serif'),textAlign: TextAlign.center,),
            CustomTextFormField(label: "Email"),
            SizedBox(height: 50,),
            CustomTextButton(buttonText: "Submit")
          ],
        ),
      ),
    ));
  }
}
