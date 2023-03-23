import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_dekho_app/Model/studentAttendenceModel.dart';
import 'package:job_dekho_app/Utils/Models/StudentDetailsModel.dart';
import 'package:job_dekho_app/Utils/style.dart';
import 'package:http/http.dart' as http;

import '../Utils/Api_path.dart';
import 'StudentAttendenceList.dart';

class ViewStudentDetailsScreen extends StatefulWidget {
  final String? student_id;
  Data? data;
  ViewStudentDetailsScreen({this.data, this.student_id});
  @override
  State<ViewStudentDetailsScreen> createState() => _ViewStudentDetailsScreenState();
}

class _ViewStudentDetailsScreenState extends State<ViewStudentDetailsScreen> {

  // String dropdownvalue = 'Picked Up';
  // var items = [
  //   'Picked Up',
  //   'Delivered',
  // ];

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getStudentAttendence();
    });
  }

  updateStatus() async {
    print("Status Api working");
    var headers = {
      'Cookie': 'ci_session=50f2596820c9567b1d95af6c2f4bffa0d347f329'
    };
    var request = http.MultipartRequest('POST',Uri.parse('${ApiPath.udpate_status_driver}'));
    request.fields.addAll({
      'student_id': '${widget.student_id}',
      'status': '0',
      'pickup_time': selectedTime == "Drop Time" ? "" : '$picUpTime',
      'drop_time': selectedTime == "Drop Time" ? '$picUpTime' : '',
    });
    print("request is here ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Update Status Driver>>>>>>>");
      var finalResponse = await response.stream.bytesToString();
      print("Print Final Response Here>>>> ${finalResponse}");
      final jsonResponse = json.decode(finalResponse);
      setState(() {

      });
      var snackBar = SnackBar(
        content: Text('${jsonResponse['msg']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Fluttertoast.showToast(msg: "${jsonResponse['msg']}");
       Navigator.pop(context);

    }
    else {
      print(response.reasonPhrase);
    }
  }

  String picUpTime = '';
  String dropTime = '';

  getCurrentTime(){
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate =  DateFormat.jm().format(DateTime.now());
        //"${dateParse.hour}:${dateParse.minute}:${dateParse.second}";

    setState(() {
      picUpTime = formattedDate.toString() ;

    });
  }

  getCurrentTime1() {
      var date = new DateTime.now().toString();

      var dateParse = DateTime.parse(date);

      var formattedDate = DateFormat.jm().format(DateTime.now());
          //"${dateParse.hour}:${dateParse.minute}:${dateParse.second}";

      setState(() {
        dropTime = formattedDate.toString() ;

      });
    }


  StudentAttendenceModel? studentAttendenceModel;

    String? selectedTime;

  getStudentAttendence()async{
    print("checking student id here ${widget.student_id}");
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'ci_session=54c31ecf7a2bb9e96f2231164df82ff608a86ef7'
    };
    var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}get_students_attendance_details'));
    request.bodyFields = {
      'id': '${widget.student_id}'
    };
    print("attendence detail ${ApiPath.baseUrl}get_students_attendance_details    and ${widget.student_id}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = StudentAttendenceModel.fromJson(json.decode(finalResult));
      setState(() {
        studentAttendenceModel = jsonResponse;
      });
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
        appBar: AppBar(
          elevation: 0,
          title: Text("View Details", style: TextStyle(fontFamily: 'Serif'),),
          centerTitle: true,

          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                // decoration: BoxDecoration(
                //   // borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
                //     color: Colors.white
                // ),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                alignment: Alignment.center,
                // width: size.width,
                // height: size.height,
                child: Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    padding: EdgeInsets.all(15),
                   // width: MediaQuery.of(context).size.width/ 1.2,
                    height: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network("${ApiPath.imageUrl}${widget.data!.profilePic}",fit: BoxFit.fill,)),
                        ),
                         SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("Student Name", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                            Text("${widget.data!.username.toString()}", style: TextStyle(fontSize: 15, fontFamily: 'Serif'),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Class", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                            Text("${widget.data!.addClass.toString()}", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Age", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                            Text("${widget.data!.age.toString()}", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [ 
                             Text("Address", style: TextStyle(fontSize: 15,fontFamily: 'Serif')),
                            Container(
                                width: MediaQuery.of(context).size.width/2.5,
                                child: Text("${widget.data!.parAddress.toString()}",maxLines: 2,textAlign: TextAlign.end, style: TextStyle(fontFamily: 'Serif'),)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text("Relation", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                            Text("${widget.data!.relation.toString()}", style: TextStyle(fontSize: 15,fontFamily: 'Serif')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Date Of Birth", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                            Text("${widget.data!.dob.toString()}", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Gender", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                            Text("${widget.data!.sex.toString()}",style: TextStyle(fontSize: 15,fontFamily: 'Serif')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            // width: size.width,
            // height: size.height,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(40),
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all()
                        ),
                        child:   DropdownButton(
                          value: selectedTime,
                          // Down Arrow Icon
                          underline: Container(),
                          hint: Text("Select Time", style: TextStyle(fontFamily: 'Serif'),),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          isExpanded: true,
                          // Array list of items
                          items: ['Pickup Time','Drop Time'].map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTime = newValue!;
                            });
                          },
                        ),
                      ),

                  picUpTime == "" ? SizedBox.shrink() :  selectedTime == "Drop Time" ? SizedBox.shrink() :   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("PickUp Time", style: TextStyle(fontSize: 15, fontFamily: 'Serif')),
                          Text("$picUpTime",style: TextStyle(fontSize: 15,fontFamily: 'Serif')),
                        ],
                      ),
                      SizedBox(height: 8,),
                  selectedTime == "Drop Time" ?  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text("Drop Time",style: TextStyle(fontSize: 15,fontFamily: 'Serif')),
                          Text("$picUpTime",style: TextStyle(fontSize: 15,fontFamily: 'Serif')),
                        ],
                      ) : SizedBox.shrink(),
                      SizedBox(height: 14,),
                      InkWell(
                        onTap: (){
                         if(selectedTime == "" || selectedTime == null){

                         }
                         else{
                           getCurrentTime();
                         }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width/2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            color: primaryColor,
                          ),
                          child: Text("Get Time",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     ElevatedButton(
                      //       style: ElevatedButton.styleFrom(
                      //         primary: primaryColor,
                      //         textStyle: const TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 10,
                      //             fontStyle: FontStyle.normal),
                      //       ),
                      //       onPressed: getCurrentTime,
                      //       child: Text('PickUp Time', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      //     ),
                      //     MaterialButton(
                      //       color: primaryColor,
                      //
                      //       // style: ElevatedButton.styleFrom(
                      //       //   primary: primaryColor,
                      //       //   textStyle: const TextStyle(
                      //       //       color: Colors.white,
                      //       //       fontSize: 10,
                      //       //       fontStyle: FontStyle.normal),
                      //       // ),
                      //       onPressed: picUpTime == "" ?  null : getCurrentTime1,
                      //       child: Text('Drop Time', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Colors.white)),
                      //     ),
                      //   ],
                      // ),
                      ///////////////////
                      // DropdownButton(
                      //   // underline:
                      //   underline:Container(),
                      //   // elevation: 14,
                      //   // dropdownColor: Colors.white,
                      //   value: dropdownvalue,
                      //   icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF5B2187),),
                      //   items: items.map((String items) {
                      //     return
                      //       DropdownMenuItem(
                      //       value: items,
                      //       child: Text(items),
                      //     );
                      //   }).toList(),
                      //   // After selecting the desired option,it will
                      //   // change button value to selected value
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownvalue = newValue!;
                      //     });
                      //   },),
                    ],
                  ),
                ),
              ),
            ),
          ),

              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  updateStatus();
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width/2.5,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500, fontFamily: 'Serif'),),
                ),
              ),
              SizedBox(height:20),
              studentAttendenceModel == null ? Center(child: CircularProgressIndicator(),) : studentAttendenceModel!.data == null ?
              Center(child: Text("No data to show", style: TextStyle(fontFamily: 'Serif')),) :   Column(
                children: [
                  Text("Child Attendance History",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18, fontFamily: 'Serif'),),
                  SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,

                              child: Text("Date",textAlign: TextAlign.end,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600, fontFamily: 'Serif'),)),
                        ),
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Pick up",textAlign: TextAlign.end,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600, fontFamily: 'Serif'),)),
                        ),
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,

                              child: Text("Drop time",textAlign: TextAlign.end,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600, fontFamily: 'Serif'),)),
                        ),
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text("Status",textAlign: TextAlign.end,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600, fontFamily: 'Serif'),)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                      shrinkWrap: true,
                      itemCount:  studentAttendenceModel!.data!.length > 7 ? 7 : studentAttendenceModel!.data!.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (c,i){
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text("${studentAttendenceModel!.data![i].date}")),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text("${studentAttendenceModel!.data![i].pickupTime}"),
                              )),
                              Expanded(child: Text("${studentAttendenceModel!.data![i].dropTime}")),
                              studentAttendenceModel!.data![i].status == "1" ? Text("Present",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 15, fontFamily: 'Serif'),) :
                              Text("Absent",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 15, fontFamily: 'Serif'),)
                            ],
                          ),
                        );
                      }),

                  SizedBox(height: 20,),

                  studentAttendenceModel!.data!.length  > 7 ?    InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAttendenceList(studentId: widget.data!.id.toString(),)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height:45,
                      width: MediaQuery.of(context).size.width/2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text("View All History",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600, fontFamily: 'Serif'),),
                    ),
                  ) : SizedBox.shrink(),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
