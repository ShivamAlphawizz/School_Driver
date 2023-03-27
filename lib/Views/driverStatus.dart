import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:job_dekho_app/Utils/Api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/style.dart';
import 'Recruiter/recruiterdrawer_Screen.dart';
import 'package:http/http.dart'as http;

class DriverStatus extends StatefulWidget {
  const DriverStatus({Key? key}) : super(key: key);

  @override
  State<DriverStatus> createState() => _DriverStatusState();
}

class _DriverStatusState extends State<DriverStatus> {
  String? DriverAbsent;
  TextEditingController DriverAbsentController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  getUpadetStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=f8914c78918cd7716c5b6b222832ecfb30bd147a'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}driver_comment_status'));
    request.fields.addAll({
      'driver_id': user_id.toString(),
      'status': feedbackController.text
    });
    print(" this is a Requst==========?>${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var finalStatus = json.decode(result);
      print("this is a final responce======>${finalStatus}");
      setState(() {

      });
      var snackBar = SnackBar(
        content: Text('${finalStatus['msg']}'),
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
              title:  Text('Driver Status', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Serif'),),

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
                    SizedBox(height: 10,),
                    Text(" Driver absent Date ", style: TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Serif')),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async{
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            // print("this is current date ${dateInput.toString()}");
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(

                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    // primary: primary, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },

                        );
                        if (pickedDate != null) {
                          print( "This is picked date" + pickedDate.toString());
                          //  pickedDate output format => 2021-03-10 00:00:00.000
                          DriverAbsent = DateFormat('dd-MM-yyyy').format(pickedDate);
                          print("final formated date here" +
                              DriverAbsent.toString()); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            // dateInput.text =
                            //     formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: DriverAbsent == null || DriverAbsent == "" ?
                            Text("Select date",style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),)
                                : Text("${DriverAbsent}",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20,),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 10,
                            child: Container(
                              height: 60,
                              child: TextFormField(
                                validator: (v){
                                  if(v!.isEmpty){
                                    return "Comment is required";
                                  }
                                },
                                controller: feedbackController,
                                decoration:
                                InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10,top: 10),
                                  border: InputBorder.none,
                                  hintText: "Comment ",
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
                            setState(() {
                              isLoading = true;
                            });
                            if(_formKey.currentState!.validate()){
                              // Navigator.pop(context,{
                              //   'feedback': feedbackController.text,
                              // });
                              getUpadetStatus();
                            }
                            else{
                              setState(() {
                                isLoading = false;
                              });
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primaryColor),color: primaryColor
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width/2,
                            child:isLoading == true ? Center(child: CircularProgressIndicator(),) : Center(child: Text('Update Date',style: TextStyle(color:whiteColor),)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ));

  }
}
