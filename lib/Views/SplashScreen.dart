import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physician/Controllers/LoginController.dart';
import 'package:physician/Models/UserModel.dart';
import 'package:physician/SharedPreferences/Preferences.dart';
import 'package:physician/Views/Home.dart';
import 'package:physician/Views/Login.dart';
import 'package:physician/main.dart';


Color _mainColor= Color(0xff68B280);
class SplashScreen extends StatefulWidget {



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), _toLogin);
  }
  _toLogin()async
  {
    String data=await Preferences.getUser();
    if(!data.isEmpty)
      {
        model.value=userModelFromJson(data);
        Get.offAll(() => Homepage());
      }
    else
      {
        Get.offAll(()=>Login());
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: _logo(context)),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: _mainColor,strokeWidth: 2,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Loading",
                      style: TextStyle(
                        fontSize: 18,
                        color: _mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget _logo(BuildContext context)
  {
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/logo.png")
          )
      ),
    );
  }
}
