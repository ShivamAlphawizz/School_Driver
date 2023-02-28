import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Views/Recruiter/recruitermyprofile_Screen.dart';
import 'package:job_dekho_app/Views/accountcreated_Screen.dart';
import 'package:job_dekho_app/Views/signin_Screen.dart';

import '../../Views/signup_Screen.dart';
import '../style.dart';
import 'TextFields/authTextField.dart';
import 'customTextButton.dart';

class JobSeekerTab extends StatelessWidget {
  const JobSeekerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          AuthTextField(iconImage: Image.asset('assets/AuthAssets/Icon material-email.png', scale: 1.3, color: primaryColor,),hintText: "Email",),
          AuthTextField(iconImage: Image.asset('assets/AuthAssets/Icon awesome-user.png', scale: 1.3, color: primaryColor,),hintText: "First Name",),
          AuthTextField(iconImage: Image.asset('assets/AuthAssets/Icon awesome-user.png', scale: 1.3, color: primaryColor,),hintText: "Last Name",),
          AuthTextField(iconImage: Image.asset('assets/AuthAssets/Icon ionic-ios-call.png', scale: 1.3, color: primaryColor,),hintText: "Mobile No.",),
          AuthTextField(iconImage: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 1.3, color: primaryColor,),hintText: "Password",),
          AuthTextField(iconImage: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 1.3, color: primaryColor,),hintText: "Confirm Password",),
          SizedBox(height: 30,),
          CustomTextButton(buttonText: 'Submit', onTap: (){Get.to(AccountCreatedScreen());},),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("I already have an account! ", style: TextStyle(color: greyColor,fontWeight: FontWeight.bold),),
              GestureDetector(onTap: (){Get.to(SignInScreen());},child: Text("Sign In", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),))
            ],
          )
        ],
      ),
    );
  }
}
