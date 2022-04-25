import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:physician/Views/AllChats.dart';
import 'package:physician/Views/Appointments/AppointmentRequests.dart';
import 'package:physician/Views/Appointments/OnAccept.dart';
import 'package:physician/Views/Home.dart';
import 'package:physician/Views/LoadingWidgets/HomeLoading.dart';
import 'package:physician/Views/Login.dart';
import 'package:physician/Views/SplashScreen.dart';
import 'package:physician/Views/WaitingRoom.dart';

import 'Views/CallScreen.dart';

var _mainColor = const Color(0xff68B280);

const APP_ID="480995d2d57f4597938c7ff5408d473b";
const Token="006480995d2d57f4597938c7ff5408d473bIACIW/QAd/3r01at8GWNeco0huUk8f32MLYt37BI6VHEGSUtuc0AAAAAEAAjgBf2EKBZYgEAAQAQoFli";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.black)),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Mont'),
      home: SplashScreen(),
    );
  }
}
