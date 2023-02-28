import 'package:flutter/material.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customTile.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/jobcardbottomtab.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Utils/iconUrl.dart';
import 'package:job_dekho_app/Views/Recruiter/postJob_Screen.dart';
import 'package:job_dekho_app/Views/updatejobpost_Screen.dart';
import 'package:job_dekho_app/Views/viewjobpost_Screen.dart';
import '../style.dart';

class JobPostCard extends StatelessWidget {
  const JobPostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 22),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(40),
        child:
        Container(
          // padding: EdgeInsets.all(15),
          width: 350,
          height: 500,
          // decoration: BoxDecoration(
          //     color: whiteColor,
          //     borderRadius: BorderRadius.circular(40)
          // ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 25),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Student Name'),
                    // JobCardBottomTile(
                    //   // editOnTap: (){Get.to(UpdateJobPostScreen());},
                    //   viewOnTap: (){Get.to(ViewJobPostScreen());},)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
