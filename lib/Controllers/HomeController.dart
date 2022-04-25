import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physician/Models/PatientModel.dart';
import 'package:physician/Models/WaitingroomModel.dart';

import '../Models/UserModel.dart';
import '../SharedPreferences/Preferences.dart';

class HomeController extends GetxController {
  var patients = <PatientModel>[].obs;
  var isLoading = false.obs;
  var roomPatient = <WaitingroomModel>[].obs;
  var physician= UserModel(name:"",pic: "",id: "",status: 0).obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();

  }

  Future loadHomeData() async {
    List<PatientModel> temp = [];
    List<WaitingroomModel> roomTemp = [];
    try {
      isLoading.value = true;
      final ref = FirebaseDatabase.instance.ref("patient");
      final roomRef = FirebaseDatabase.instance
          .ref("room");
      ref.onValue.listen((event) {
        temp.clear();
        if(event.snapshot!=null)
          {

            for (DataSnapshot snap in event.snapshot.children) {
              if (snap.child('history').value != null) {
                var json = jsonEncode(snap.value);
                var model = patientModelFromJson(json);
                temp.add(model);
              }
            }
            patients.value = temp;
          }
        roomRef.onValue.listen((event) async {
          roomPatient.clear();
          if(event.snapshot.value!=null)
          {
            for(DataSnapshot snapshot in event.snapshot.children)
            {
              Map roomData=new Map();
              String key=snapshot.key.toString();
              String date=snapshot.child("date").value.toString();
              String time=snapshot.child("time").value.toString();
              String id=snapshot.child("id").value.toString();
              String pid=snapshot.child("pid").value.toString();
              var patientData=await FirebaseDatabase.instance.ref("patient").child(id).once();
              var physicianData=await FirebaseDatabase.instance.ref("physician").child(pid).once();
              Map patientMap=patientData.snapshot.value as Map;
              Map physicianMap=physicianData.snapshot.value as Map;
              roomData.addIf(true,"key",key);
              roomData.addIf(true, "date", date);
              roomData.addIf(true, "time", time);
              roomData.addIf(true, "patient", patientMap);
              roomData.addIf(true, "physician", physicianMap);
              roomPatient.add(waitingroomModelFromJson(jsonEncode(roomData)));
            }
          }
        });
      });
      await getMyData(FirebaseAuth.instance.currentUser!.uid);
      isLoading.value = false;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }catch(e)
    {
      isLoading.value=false;
      Get.snackbar("Error", e.toString());
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
        physician.value=userModelFromJson(jsonEncode(data));
        isLoading.value=false;
      });
    }catch(e)
    {
      isLoading.value=false;
      Get.snackbar("Error", e.toString());
    }
  }

}
