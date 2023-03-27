import 'package:flutter/material.dart';
import 'package:job_dekho_app/Utils/style.dart';

class CustomNotificaitonTile extends StatelessWidget {
  final String username;
  final String? time,description;
   CustomNotificaitonTile({Key? key, required this.username, required this.time,this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15,),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          width: 350,
          height: 110,
          child: Column(
            children: [
              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: [
                  Text(username, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text(time.toString(), style: TextStyle(fontFamily: 'Serif', color: greyColor2,fontSize: 12, fontWeight: FontWeight.bold),),
                ],
              ),
              Text("${description}", style: TextStyle(fontFamily: 'Serif'))
            ],
          ),
        ),
    );
  }
}
