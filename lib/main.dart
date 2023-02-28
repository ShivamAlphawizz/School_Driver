import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_dekho_app/Views/splash_Screen.dart';

import 'Services/push_notification_service.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
  runApp( MyApp());

}


class MyApp extends StatelessWidget {
   MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SchoolManagement Driver',
      theme: ThemeData(
        // fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        fontFamily: ' Tilt Prism ',
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(),
      ),
      home: SplashScreen(),
    );
  }
}