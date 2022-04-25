
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physician/Models/UserModel.dart';
import 'package:physician/SharedPreferences/Preferences.dart';
import 'package:physician/Views/Home.dart';

var model=UserModel(name: "",id: "",pic: "",status: 0).obs;
class LoginController extends GetxController
{
  var isLoading=false.obs;

  Future Login(String email,String pass)async
  {
    isLoading.value=true;

    try {
      UserCredential uc = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email, password: pass);
      if(uc.user!=null)
        {
          await getMyData(uc.user!.uid);
        }
    }on FirebaseException catch(e)
    {
      isLoading.value=false;
      Get.snackbar("Error", e.message.toString());
    }
  }
  Future getMyData(String id )async
  {
    List<UserModel> temp=[];
    try{
      final ref=FirebaseDatabase.instance.ref("physician");
      ref.child(id).onValue.listen((event)async {
        temp.clear();
        Map data=event.snapshot.value as Map;
        await Preferences.setUser(jsonEncode(data));
        model.value=userModelFromJson(jsonEncode(data));
        isLoading.value=false;
        Get.offAll(()=>Homepage());
      });
    }catch(e)
    {
      isLoading.value=false;
      Get.snackbar("Error", e.toString());
    }
  }
}