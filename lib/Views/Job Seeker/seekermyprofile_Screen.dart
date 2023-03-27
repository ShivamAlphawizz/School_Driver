import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customDropDownTextField.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextFormField.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customButtonWithIcon.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterdrawer_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/searchcandidate_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../Services/push_notification_service.dart';
import '../../Utils/Api_path.dart';
import '../../Utils/CustomWidgets/customTextButton.dart';
import '../../Utils/CustomWidgets/jobPostCard.dart';
import '../../Utils/Models/StudentDetailsModel.dart';
import '../../Utils/style.dart';
import 'package:http/http.dart' as http;
import '../ViewStudentDetailsScreen.dart';
import '../notification_Screen.dart';
import '../updatejobpost_Screen.dart';
import 'seekerdrawer_Screen.dart';

class SeekerProfileDetailScreen extends StatefulWidget {
  final String? user_id;
  SeekerProfileDetailScreen({this.user_id});

  @override
  State<SeekerProfileDetailScreen> createState() => _SeekerProfileDetailScreenState();
}

class _SeekerProfileDetailScreenState extends State<SeekerProfileDetailScreen> {

 // Data? detailsModel;
 StudentDetailsModel? studentDetailsModel;
 Future<StudentDetailsModel?>studentDetails(String? id) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? user_id = prefs.getString('user_id');
   print("print id here ${user_id}");
   var headers = {
     'Cookie': 'ci_session=e51f2b8d8f46fc0ca9897e617308398adca216f1'
   };
   var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.get_student_details}'));
   request.fields.addAll({
     'id': '${user_id}',
     'shift':id == ""||id== null ? "":id == "Morning" ? "1":"2"
   });
   print("paramter here ${request.fields} and ${ApiPath.get_student_details}");
   request.headers.addAll(headers);
   http.StreamedResponse response = await request.send();
   if (response.statusCode == 200) {
     print("working@@@@@@@");
     var finalResponse = await response.stream.bytesToString();
     print("ok answer here ${finalResponse}");
     final jsonResponse = StudentDetailsModel.fromJson(json.decode(finalResponse));
     print("final response here ${jsonResponse}");
     setState(() {
       studentDetailsModel = jsonResponse;
     });
     print("test here ${studentDetailsModel}");

     // print(await response.stream.bytesToString());
   }
   else {
     print(response.reasonPhrase);
   }
 }
 String? selectedShift;

@override
  void initState() {
    // TODO: implement initState
  PushNotificationService pushNotificationService = new PushNotificationService(context: context);
  pushNotificationService.initialise();
      Future.delayed(Duration(microseconds: 500),(){
        return  studentDetails('');
      });
    super.initState();
  getCurrentLoc();
  }

 Future _refresh() async{
  return studentDetails('');
 }

 Future<bool> showExitPopup() async {
   return await showDialog( //show confirm dialogue
     //the return value will be from "Yes" or "No" options
     context: context,
     builder: (context) => AlertDialog(
       title: Text('Exit App', style: TextStyle(fontFamily: 'Serif')),
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
           child:Text('Yes', style: TextStyle(fontFamily: 'Serif')),
         ),

       ],
     ),
   )??false; //if showDialouge had returned null, then return false
 }

  List<String> studentIdList = [];
  String? selectedTime;
  bool allSelected = false;
 bulkUpdate()async{
   var formattedDate =  DateFormat.jm().format(DateTime.now());
   String result = studentIdList.join(",");
   var headers = {
     'Cookie': 'ci_session=dd1d0dc923efab35ae5d39f63e376741059e147b'
   };
   var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}all_student_update'));
   request.fields.addAll({
     'student_id': result,
     'status': '1',
     'pickup_time': selectedTime == "Pickup Time" ? '${formattedDate}' : "",
      'drop_time': selectedTime == "Drop Time" ? "${formattedDate}" : "", 
   });
   print("paramters are here ${request.fields}");
   request.headers.addAll(headers);
   http.StreamedResponse response = await request.send();
   if (response.statusCode == 200) {
     var finalResult = await response.stream.bytesToString();
     final jsonResponse = json.decode(finalResult);
     print("json response here ${jsonResponse}");
     setState(() {
        studentIdList.clear();
        // selectedTime = null;
        allSelected = false;
     });
     var snackBar = SnackBar(

       content: Text('${jsonResponse['msg']}'),
     );
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
   }
   else {
     print(response.reasonPhrase);
   }
 }
  String? gender;


 /// get currnt loaction

 var latitude;
 var longitude;

 String? currentAddress;
 Future<void> getCurrentLoc() async {
   LocationPermission permission;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   permission = await Geolocator.requestPermission();
   Position position = await Geolocator.getCurrentPosition(
       desiredAccuracy: LocationAccuracy.high);
   latitude = position.latitude.toString();
   longitude = position.longitude.toString();
   prefs.setString('lat', '${latitude}');
   prefs.setString('long', '${longitude}');
   print("latitude ${latitude} and ${longitude}");
   List<Placemark> placemark = await placemarkFromCoordinates(
       double.parse(latitude!), double.parse(longitude!),
       localeIdentifier: "en");

   if (mounted) {
     setState(() {
       currentAddress = "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}, ${placemark[0].administrativeArea}, ${placemark[0].country}";
      // print("checking currrent address ${currentAddress}");
       updateDriverLocation();
       // latitude = position.latitude.toString();
       // longitude = position.longitude.toString();
       // loc.lng = position.longitude.toString();
       // loc.lat = position.latitude.toString();
     });
   }
 }
  updateDriverLocation()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String? userid = prefs.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=d017e0eeefffea5b8236f606037bac17a2eda922'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}udpate_address'));
    request.fields.addAll({
      'driver_id': '${userid}',
      'address': '${currentAddress}',
      'lat': '${latitude}',
      'lang': '${longitude}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      if(jsonResponse['response_code'] == "1"){
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }


 @override
  Widget build(BuildContext context) {
   getCurrentLoc();
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child:
        RefreshIndicator(
          onRefresh: _refresh,
          child: WillPopScope(
            onWillPop: showExitPopup,
            child: Scaffold(
      // backgroundColor: primaryColor,
      appBar: AppBar(
            leading: GestureDetector(
              onTap: (){
                Get.to(DrawerScreen());
              },
              child: Image.asset('assets/ProfileAssets/menu_icon.png', scale: 1.6,),
            ),
            elevation: 0,
            backgroundColor: primaryColor,
            title: Text('Student List', style: TextStyle(fontFamily: 'Serif'),),
            centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                },
                child: Icon(Icons.notifications,color: Colors.white,)),
          )
        ],
      ),
      // backgroundColor: primaryColor,
              bottomNavigationBar: studentIdList.length == 0 ? SizedBox.shrink() : Container(
                padding: EdgeInsets.all(10),
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white)
                        ),
                        child:    DropdownButton(
                          dropdownColor: primaryColor,
                          underline: Container(),
                          isExpanded: true,
                          value: selectedTime,
                          hint: Text("Select Time",style: TextStyle(color: Colors.white, fontFamily: 'Serif'),),
                          // Down Arrow Icon
                          icon:  Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                          items: ['Pickup Time','Drop Time'].map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items,style: TextStyle(color: Colors.white, fontFamily: 'Serif'),),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTime = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 25,),
                    Expanded(
                      child: InkWell(
                          onTap: (){
                            if(selectedTime == "" || selectedTime == null){

                            }
                            else{
                              bulkUpdate();
                            }
                          },
                          child: Text("Apply",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 17, fontFamily: 'Serif'),)),
                    ),
                  ],
                ),
              ),
      body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      allSelected = !allSelected;
                    });
                    for (var ind = 0; ind <= studentDetailsModel!.data!.length; ind ++) {
                      if(studentIdList.contains(studentDetailsModel!.data![ind].id.toString())){
                        setState(() {
                          studentIdList.remove(studentDetailsModel!.data![ind].id.toString());
                        });
                      }
                      else{
                        setState(() {
                          studentIdList.add(studentDetailsModel!.data![ind].id.toString());
                        });
                      }
                    }

                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Select All",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: primaryColor)
                          ),
                          child: allSelected ?
                         const  Icon( Icons.check ,size: 18,)
                              : const Icon(Icons.check,color: Colors.transparent,),
                        ),
                        SizedBox(width: 10,)
                      ],
                    )

                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 25,left: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.centerRight,
                      width: 130,
                    child:  DropdownButton(
                      value: selectedShift,
                      underline: Container(),
                      hint: Text("Select Shift"),
                      icon: Icon(Icons.keyboard_arrow_down),
                      items: ['Morning','Evening'].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedShift = newValue.toString();
                          studentDetails('${selectedShift}');
                        });
                        print("selected shift here ${selectedShift}");
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
                        color: Color(0xffF9F9F9)
                    ),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height,
                    child:
                    // studentDetailsModel == null ?
                    studentDetailsModel == null ? Center(child: CircularProgressIndicator(),) : studentDetailsModel!.data == null  ?
                    Center(child: Text("No data to show", style: TextStyle(fontFamily: 'Serif')),) :
                    ListView.builder(
                        itemCount: studentDetailsModel!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.only(bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage("${ApiPath.imageUrl}${studentDetailsModel!.data![index].profilePic}"),
                                        ),
                                      ),
                                    ),

                                    InkWell(
                                      onTap: (){
                                        if(studentIdList.contains(studentDetailsModel!.data![index].id.toString())){
                                          setState(() {
                                            studentIdList.remove(studentDetailsModel!.data![index].id.toString());
                                          });
                                        }
                                        else{
                                          setState(() {
                                            studentIdList.add(studentDetailsModel!.data![index].id.toString());
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(color: primaryColor)
                                        ),
                                        child: studentIdList.contains(studentDetailsModel!.data![index].id.toString()) ? Icon(Icons.check,size: 18,) : Icon(Icons.check,color: Colors.transparent,),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Student Name", style: TextStyle(fontFamily: 'Serif')),
                                    Text("${studentDetailsModel!.data![index].username.toString()}"),
                                  ],
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Class", style: TextStyle(fontFamily: 'Serif')),
                                    Text("${studentDetailsModel!.data![index].addClass.toString()}"),
                                  ],
                                ),
                                SizedBox(height: 3,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     const Text("Age"),
                                //     Text("${studentDetailsModel!.data![index].age.toString()}"),
                                //   ],
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Address", style: TextStyle(fontFamily: 'Serif')),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text("${studentDetailsModel!.data![index].parAddress.toString()}",maxLines: 1,textAlign: TextAlign.end, style: TextStyle(fontFamily: 'Serif'),overflow: TextOverflow.ellipsis,)),
                                  ],
                                ),
                                SizedBox(height: 3,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     const Text("Relation"),
                                //     Text("${studentDetailsModel!.data![index].relation.toString()}"),
                                //   ],
                                // ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text("Date Of Birth"),
                                //     Text("${studentDetailsModel!.data![index].dob.toString()}"),
                                //   ],
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Gender", style: TextStyle(fontFamily: 'Serif')),
                                    Text("${studentDetailsModel!.data![index].sex.toString()}", style: TextStyle(fontFamily: 'Serif')),
                                  ],
                                ),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width/2,
                                  margin: EdgeInsets.only(top: 10),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewStudentDetailsScreen(data: studentDetailsModel!.data![index],student_id: studentDetailsModel!.data![index].id)));
                                    }, child:  Text("View Details", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                  // : CircularProgressIndicator(color: primaryColor),
                  // ListView.builder(
                  //     itemCount: details.length,
                  //     itemBuilder: (BuildContext context, int index){
                  //       // return
                  //       //   Container(
                  //       //   padding: EdgeInsets.all(15),
                  //       //   height: 100,
                  //       //   width: 330,
                  //       //   // width: 350,
                  //       //   // height: 500,
                  //       //   decoration: BoxDecoration(
                  //       //       // color: Colors.green,
                  //       //       borderRadius: BorderRadius.circular(40)
                  //       //   ),
                  //       //   child: Padding(
                  //       //     padding: const EdgeInsets.all(10.0),
                  //       //     child: Row(
                  //       //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //       children: [
                  //       //         Text("Student Name"),
                  //       //         Text("${details[0].username.toString()}"),
                  //       //       ],
                  //       //     ),
                  //       //   ),
                  //       // );
                  //       return JobPostCard();
                  //     })
                  // Column(
                  //   //mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     JobPostCard(),
                  //     JobPostCard(),
                  //     JobPostCard()
                  //   ],
                  // ),
                ),
              ),
            ],
          )

    ),
          ),
        ),
    );
  }
}
