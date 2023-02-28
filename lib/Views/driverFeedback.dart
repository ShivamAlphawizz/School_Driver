import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart'as http;
import 'package:job_dekho_app/Utils/Api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/style.dart';
import 'Recruiter/recruiterdrawer_Screen.dart';

class DriveFeedback extends StatefulWidget {
  const DriveFeedback({Key? key}) : super(key: key);

  @override
  State<DriveFeedback> createState() => _DriveFeedbackState();
}

class _DriveFeedbackState extends State<DriveFeedback> {
  TextEditingController feedbackController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  getfeedback() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print("Get Profile Api Working${user_id}");
    var headers = {
      'Cookie': 'ci_session=adf49898cd74faa6fd5bdafa39c65c8c96fc5889'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}driver_comment_status'));
    request.fields.addAll({
      'driver_id': user_id.toString(),
      'status': feedbackController.text
    });
    print(" this mfdgg${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var finalData = json.decode(result);
      print("this is a final responce======>${finalData}");
      var snackBar = SnackBar(
        content: Text('${finalData['msg']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        feedbackController.clear();
      });
     Navigator.pop(context);
    }
    else {
    print(response.reasonPhrase);
    }

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
              title:  Text('Driver Feedback', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Serif'),),

            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(90)),
                  color: Colors.white
              ),
              width: size.width,
              height: size.height,
              child:Form(
                key: _formKey,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20,),
                          Card(
                            elevation: 10,
                            child: Container(
                              height: 60,
                              child: TextFormField(
                                validator: (v){
                                  if(v!.isEmpty){
                                    return "Feedback is required";
                                  }
                                },
                                controller: feedbackController,
                                decoration:
                              InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10,top: 10),
                                border: InputBorder.none,
                                hintText: "Feedback ",
                              ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: InkWell(
                          onTap: (){
                            if(_formKey.currentState!.validate()){
                              getfeedback();
                            }
                            else{
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Center(child: Text('Feedback Fields are required')),
                              //     )
                              // );
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primaryColor),color: primaryColor

                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width/2,
                            child: Center(child: Text('Feedback',style: TextStyle(color:whiteColor, fontFamily: 'Serif'),)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ));
    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       elevation: 0,
    //       centerTitle: true,
    //       backgroundColor: primaryColor,
    //       leading: GestureDetector(
    //         onTap: () {
    //           Get.to(DrawerScreen());
    //         },
    //         child: Icon(Icons.arrow_back_ios, color: whiteColor, size: 20),
    //         //Icon(Icons.arrow_back_ios, color: whiteColor, size: 22),
    //       ),
    //       title: Text(
    //         'Driver Feedback',
    //         style: TextStyle(
    //             color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //     body: Form(
    //       key: _formKey,
    //       child: ListView(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.symmetric(
    //                 vertical: 16.0, horizontal: 32.0),
    //             child: Column(
    //               children: [
    //                 TextFormField(
    //                   validator: (v) {
    //                     if (v!.isEmpty) {
    //                       return "Name is required";
    //                     }
    //                   },
    //                   controller: nameController,
    //                   decoration: InputDecoration(
    //                     hintText: "Name ",
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Center(
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 20.0),
    //               child: Row(
    //                 children: [
    //                   InkWell(
    //                     onTap: () {
    //                       if (_formKey.currentState!.validate()) {
    //                         Navigator.pop(context, {
    //                           'name': nameController.text,
    //                         });
    //                         // franchise();
    //                       } else {
    //                         // Fluttertoast.showToast(msg: "All Fields are required");
    //                       }
    //                     },
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Container(
    //                         decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(10),
    //                             border: Border.all(color: primaryColor),
    //                             color: primaryColor),
    //                         height: 40,
    //                         width: 80,
    //                         child: Center(
    //                             child: Text(
    //                           'Submit',
    //                           style: TextStyle(color: Colors.black),
    //                         )),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
