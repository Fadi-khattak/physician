import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:physician/Models/WaitingroomModel.dart';

import '../Models/PatientModel.dart';

class WaitingRoomController extends GetxController {
  var isLoading = false.obs;
  var roomPatient = <WaitingroomModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getDetails();
  }

  Future _getDetails() async {
    List<WaitingroomModel> roomTemp = [];
    try {
      final roomRef = FirebaseDatabase.instance
          .ref("room");
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
    } on FirebaseException catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.message.toString());
    }
  }
}
