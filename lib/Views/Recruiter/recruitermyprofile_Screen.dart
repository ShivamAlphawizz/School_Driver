import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Model/driverModel.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customDetailTextField.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customTextButton.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextFormField.dart';
import 'package:job_dekho_app/Utils/style.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterdrawer_Screen.dart';
import 'package:job_dekho_app/Views/notification_Screen.dart';
import 'package:job_dekho_app/Views/updatejobpost_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Api_path.dart';
import '../../Utils/Models/UpdateProfileModel.dart';

class RecruiterMyProfileScreen extends StatefulWidget {
  RecruiterMyProfileScreen({this.user_id});
  final String? user_id;
  // const RecruiterMyProfileScreen({Key? key}) : super(key: key);

  @override
  State<RecruiterMyProfileScreen> createState() => _RecruiterMyProfileScreenState();
}

class _RecruiterMyProfileScreenState extends State<RecruiterMyProfileScreen> {

  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController mobileCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  TextEditingController vehicletypeCtr = TextEditingController();
  TextEditingController vehiclenumberCtr = TextEditingController();
  TextEditingController timeshiftCtr = TextEditingController();
  TextEditingController addresCtr = TextEditingController();

  // Data UpdateProfileModel;

  // File? aadharImage;
  // File? drivingLicenseImage;
  // File? panImage;
  // File? rcImage;


  DriverModel? driverModel;


  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('user_id');
    print("Get Profile Api Working ");
    var headers = {
      'Cookie': 'ci_session=9efb89aaeed7b77d7a3602cf0a767a6bff4440a2'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}get_driver_profile'));
    request.fields.addAll({
      'id': '${user_id}',
    });
    print("checking data here ${request.fields} and ${ApiPath.baseUrl}get_driver_profile");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = DriverModel.fromJson(json.decode(finalResult));
      setState(() {
        driverModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  UpdateProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString(widget.user_id.toString());
    print("Update Profile Api Working ");
  var headers = {
    'Cookie': 'ci_session=d77473ded6ed9d88eb750474d879bbb104cfef95'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}update_profile'));
  request.fields.addAll({

  'id': "${user_id.toString()}",
  'school_id': '1',
  'name': '${nameCtr.text}',
  'email': '${emailCtr.text}',
  'mobile': '${mobileCtr.text}',
  'vehicle_number': '${vehiclenumberCtr.text}',
  'lat': 'd',
  'lang': '4',
  'address': '${addresCtr.text.toString()}',
  // 'vehicle_number': '8',
  'vehicle_type': '${vehicletypeCtr.text.toString()}',
  'time_shift5': '${timeshiftCtr.text.toString()}',
  // 'delivery_type': '5',
  });
  // aadharImage ==  null ? null : request.files.add(await http.MultipartFile.fromPath('adhar', aadharImage!.path.toString()));
  // rcImage ==  null ? null : request.files.add(await http.MultipartFile.fromPath('rc_book', rcImage!.path.toString()));
  // panImage ==  null ? null : request.files.add(await http.MultipartFile.fromPath('pan', panImage!.path.toString()));
  // drivingLicenseImage ==  null ? null : request.files.add(await http.MultipartFile.fromPath('driving_license', drivingLicenseImage!.path.toString()));

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var finalResponse = await response.stream.bytesToString();
    final jsonResponse = UpdateProfileModel.fromJson(json.decode(finalResponse));
    setState(() {
      // UpdateProfileModel = jsonResponse.data;
    });
  print(await response.stream.bytesToString());
  }
  else {
  print(response.reasonPhrase);
  }
}

  String? profileType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return   getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: (){
                Get.to(DrawerScreen());
              },
              child: Image.asset('assets/ProfileAssets/menu_icon.png', scale: 1.6,),
            ),
            elevation: 0,
            backgroundColor: primaryColor,
            title: Text('My Profile', style: TextStyle(fontFamily: 'Serif')),
            centerTitle: true,

          ),
          backgroundColor: primaryColor,
          body: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height/1.1,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: profileBg,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
              ),
              child:driverModel == null  ? Center(child: CircularProgressIndicator(),) : driverModel!.data ==  null ?
              Center(child: Text("No data to show", style: TextStyle(fontFamily: 'Serif')),) :  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      // showModalBottomSheet(
                      //     context: context,
                      //     builder: (context) {
                      //       return Container(
                      //         height: 250,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                      //         ),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(" Job Portal: Take Image From", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      //             ListTile(leading: Image.asset('assets/ProfileAssets/cameraicon.png', scale: 1.5,),
                      //               title: Text('Camera', style: TextStyle(fontWeight: FontWeight.bold)),
                      //             ),
                      //             ListTile(leading: Image.asset('assets/ProfileAssets/galleryicon.png', scale: 1.5,),
                      //               title: Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold)),
                      //             ),
                      //             ListTile(leading: Image.asset('assets/ProfileAssets/cancelicon.png', scale: 1.5,),
                      //               title: Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold)),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     });
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: whiteColor
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network('${ApiPath.imageUrl}${driverModel!.data!.profileImage}',fit: BoxFit.fill,)),
                          ),
                          // Positioned(
                          //     bottom: 20,
                          //     right: 10,
                          //     child: Container(
                          //       width: 30,
                          //       height: 30,
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           shape: BoxShape.circle
                          //       ),
                          //       child: Image.asset('assets/ProfileAssets/camera_Icon.png', scale: 1.8,),
                          //     ),),
                        ],
                      ),
                    ),
                  ),
                  // Text('I Am ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: greyColor1),),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //    Row(
                  //      children: [
                  //        Radio(
                  //          activeColor: primaryColor,
                  //          // title: Text("Male"),
                  //          value: "employee",
                  //          groupValue: profileType,
                  //          onChanged: (value){
                  //            setState(() {
                  //              profileType = value.toString();
                  //            });
                  //          },
                  //        ),
                  //        Text("An Employee", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: primaryColor),)
                  //      ],
                  //    ),
                  //     Row(
                  //       children: [
                  //         Radio(
                  //           activeColor: primaryColor,
                  //           // title: Text("Female"),
                  //           value: "consultant",
                  //           groupValue: profileType,
                  //           onChanged: (value){
                  //             setState(() {
                  //               profileType = value.toString();
                  //             }
                  //             );
                  //           },
                  //         ),
                  //         Text("A Consultant", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: primaryColor),),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Radio(value: 0, groupValue: _value, onChanged: (value){}),
                  //         Text('An Employer', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold ),),
                  //       ],
                  //     ),
                  //     Row(
                  //       children: [
                  //         Radio(value: 1, groupValue: _value1, onChanged: (value1){}),
                  //         Text('A Consultant', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold ),),
                  //       ],
                  //     )
                  //   ],
                  // ),

                  Text("Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15, fontFamily: 'Serif'),),
                  SizedBox(height: 5,),
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.centerLeft,
                      child: Text("${driverModel!.data!.uname}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),)
                    ),
                  ),
                  SizedBox(height: 12,),
                  Text("Email",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15, fontFamily: 'Serif'),),
                  SizedBox(height: 5,),
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Text("${driverModel!.data!.email}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),)
                    ),
                  ),
                  SizedBox(height: 12,),
                  Text("Mobile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15, fontFamily: 'Serif'),),
                  SizedBox(height: 5,),
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Text("${driverModel!.data!.mobile}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),)
                    ),
                  ),

                  SizedBox(height: 12,),
                  Text("Address",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15, fontFamily: 'Serif'),),
                  SizedBox(height: 5,),
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Text("${driverModel!.data!.address}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),maxLines: 1,)
                    ),
                  ),

                  SizedBox(height: 12,),
                  Text("Vehicle Number",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15, fontFamily: 'Serif'),),
                  SizedBox(height: 5,),
                  Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: Text("${driverModel!.data!.vehicleNumber}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),)
                    ),
                  ),
                  ////////////////////////////////////////////////////////////////////
                  //
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         controller: nameCtr,
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your name';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Name",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         keyboardType: TextInputType.emailAddress,
                  //         controller: emailCtr,
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your name';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Email",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         keyboardType: TextInputType.number,
                  //         controller: mobileCtr,
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your name';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Mobile",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         controller: passwordCtr,
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your name';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Password",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         controller: vehiclenumberCtr,
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your name';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Vehicle No.",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         controller: vehicletypeCtr,
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your name';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Vehicle Type",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         controller: timeshiftCtr,
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your name';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Time Shift",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         controller: addresCtr,
                  //         validator: (value) {
                  //           if (value == null || value.isEmpty) {
                  //             return 'Please enter your name';
                  //           }
                  //           return null;
                  //         },
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Address",
                  //           suffixIcon: Icon(Icons.my_location, color: Color(0xFF5B2187),
                  //           // IconButton(
                  //           //   icon: Icon(
                  //           //     Icons.my_location,
                  //           //     color: Color(oxff68970),
                  //           //   ),
                  //             // focusNode: locationFocus,
                  //             // onPressed: () async {
                  //             //   LocationPermission permission;
                  //             //   permission = await Geolocator.requestPermission();
                  //             //   Position position = await Geolocator.getCurrentPosition(
                  //             //       desiredAccuracy: LocationAccuracy.high);
                  //             //   await Navigator.push(
                  //             //       context,
                  //             //       MaterialPageRoute(
                  //             //           builder: (context) => Map(
                  //             //             latitude:
                  //             //             latitude == null || latitude == ""
                  //             //                 ? position.latitude
                  //             //                 : double.parse(latitude!),
                  //             //             longitude:
                  //             //             longitude == null || longitude == ""
                  //             //                 ? position.longitude
                  //             //                 : double.parse(longitude!),
                  //             //             from:
                  //             //             getTranslated(context, 'ADDADDRESS'),
                  //             //           )));
                  //             //   if (mounted) setState(() {});
                  //             //   List<Placemark> placemark =
                  //             //   await placemarkFromCoordinates(
                  //             //       double.parse(latitude!),
                  //             //       double.parse(longitude!));
                  //             //   var address;
                  //             //   address = placemark[0].name;
                  //             //   address = address + "," + placemark[0].subLocality;
                  //             //   address = address + "," + placemark[0].locality;
                  //             //
                  //             //   state = placemark[0].administrativeArea;
                  //             //   country = placemark[0].country;
                  //             //   // pincode = placemark[0].postalCode;
                  //             //   //  address = placemark[0].name;
                  //             //   if (mounted) {
                  //             //     setState(() {
                  //             //       countryC!.text = country!;
                  //             //       stateC!.text = state!;
                  //             //       addressC!.text = address;
                  //             //       //  pincodeC!.text = pincode!;
                  //             //       // addressC!.text = address!;
                  //             //     });
                  //             //   }
                  //             // },
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         // controller: addresCtr,
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Aadhar",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Pan",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Drivining License",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15,),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 14),
                  //   child: Material(
                  //     elevation: 10,
                  //     borderRadius: BorderRadius.circular(10),
                  //     child: Container(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       height: 60,
                  //       child: TextFormField(
                  //         // controller: addresCtr,
                  //         decoration: const InputDecoration(
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //           ),
                  //           hintText: "Rc Book",
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // // CustomTextFormField(label: 'Company Name', labelColor: greyColor),
                  // // CustomTextFormField(label: 'Name', labelColor: greyColor),
                  // // CustomTextFormField(label: 'Email', labelColor: greyColor),
                  // // CustomTextFormField(label: 'Mobile', labelColor: greyColor),
                  // // CustomTextFormField(label: 'Location', labelColor: greyColor),
                  // // CustomTextFormField(label: 'Address', labelColor: greyColor),
                  // // CustomTextFormField(label: 'Website Address', labelColor: greyColor),
                  // // CustomDetailTextField(labelText: "Write A Short Desciption Of Your\nCompany Which Will Show In Your Profile*", maxLines: 4, labelColor: greyColor,),
                  // SizedBox(height: 30,),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: CustomTextButton(buttonText: "Update", onTap: (){UpdateProfile();},),
                  // ),
                  // SizedBox(height: 50,)
                ],
              ))),
    ));
  }


  // Future<void> getAadharFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       aadharImage =  File(pickedFile.path);
  //       // imagePath = File(pickedFile.path) ;
  //       // filePath = imagePath!.path.toString();
  //     });
  //   }
  // }

  // Future<void> getAadharFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       aadharImage =  File(pickedFile.path);
  //       // imagePath = File(pickedFile.path) ;
  //       // filePath = imagePath!.path.toString();
  //     });
  //   }
  // }

  // uploadAadharFromCamOrGallary(BuildContext context) {
  //   containerForSheet<String>(
  //     context: context,
  //     child: CupertinoActionSheet(
  //       actions: <Widget>[
  //         CupertinoActionSheetAction(
  //           child: Text(
  //             "Camera",
  //             style: TextStyle(color: Colors.black, fontSize: 15),
  //           ),
  //           onPressed: () {
  //             getAadharFromCamera();
  //             Navigator.of(context, rootNavigator: true).pop("Discard");
  //           },
  //         ),
  //         CupertinoActionSheetAction(
  //           child: Text(
  //             "Photo & Video Library",
  //             style: TextStyle(color: Colors.black, fontSize: 15),
  //           ),
  //           onPressed: () {
  //             getAadharFromGallery();
  //             Navigator.of(context, rootNavigator: true).pop("Discard");
  //           },
  //         ),
  //       ],
  //       cancelButton: CupertinoActionSheetAction(
  //         child: Text(
  //           "Cancel",
  //           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  //         ),
  //         isDefaultAction: true,
  //         onPressed: () {
  //           // Navigator.pop(context, 'Cancel');
  //           Navigator.of(context, rootNavigator: true).pop("Discard");
  //         },
  //       ),
  //     ),
  //   );
  // }

  // Widget imageUpload(){
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 5.0, bottom: 5),
  //         child: Text("Image Upload",
  //           style: TextStyle(
  //             fontSize: 15,
  //             // color:colors.primary,
  //           ),),
  //       ),
  //       imageAadhar(),
  //     ],
  //   );
  // }

  // Widget imageAadhar() {
  //   return Material(
  //     // elevation: 2,
  //     borderRadius: BorderRadius.circular(15),
  //     child: InkWell(
  //       onTap: () {
  //         uploadAadharFromCamOrGallary(context);
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.only(right: 25, left: 10),
  //         child: Container(
  //           height: 80,
  //           width: MediaQuery.of(context).size.width /1.3,
  //           decoration: BoxDecoration(
  //               border: Border.all(color: Colors.grey),
  //               borderRadius: BorderRadius.circular(15)
  //           ),
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(15),
  //             child: aadharImage != null ?
  //             Stack(
  //               children: [
  //                 Container(
  //                     width: double.infinity,
  //                     child: Image.file(aadharImage!, fit: BoxFit.fill)),
  //                 Align(alignment: Alignment.topRight,
  //                   child: InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         aadharImage = null;
  //                       });
  //                     },
  //                     child: Container(
  //                       padding: EdgeInsets.all(5),
  //                       margin: EdgeInsets.only(top: 10,right: 10),
  //                       decoration: BoxDecoration(
  //                           // color: colors.primary,
  //                           borderRadius: BorderRadius.circular(100)
  //                       ),
  //                       child: Icon(
  //                         Icons.clear,color: Colors.white, size: 18,
  //                       ),
  //                     ),
  //                   ),),
  //               ],
  //             )
  //                 : Column(
  //               children: [
  //                 Icon(Icons.person, size: 30),
  //                 Text("Image Upload")
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

