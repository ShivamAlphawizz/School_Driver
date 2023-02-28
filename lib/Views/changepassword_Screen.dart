import 'package:flutter/material.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextField.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/passwordTextField.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customTextButton.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextFormField.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Views/Recruiter/appliedjobs_Screens.dart';
import '../Utils/style.dart';
import 'Recruiter/recruiterdrawer_Screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.to(DrawerScreen());
          },
          child: Image.asset('assets/ProfileAssets/menu_icon.png', scale: 1.6,),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(70))
        ),
        //padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            SizedBox(height: 40,),
            PasswordTextField(label: 'Old Password', labelColor: greyColor3,),
            PasswordTextField(label: 'New Password', labelColor: greyColor3,),
            PasswordTextField(label: 'Confirm New Password', labelColor: greyColor3,),
            SizedBox(height: 40,),
            CustomTextButton(buttonText: "Update", onTap: (){Get.to(DrawerScreen());},)
          ],
        ),
      ),
    ));
  }
}
