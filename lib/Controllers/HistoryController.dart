import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Models/PatientModel.dart';

class HistoryController extends GetxController {
  var isLoading = false.obs;
  var patients = <PatientModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getDetails();
  }

  Future _getDetails() async {
    List<PatientModel> temp = [];
    final ref = FirebaseDatabase.instance.ref("patient");
    try {
      ref.onValue.listen((event) {
        temp.clear();
        for (DataSnapshot snap in event.snapshot.children) {
          if (snap.child('history').value != null) {
            var json = jsonEncode(snap.value);
            var model = patientModelFromJson(json);
            temp.add(model);
          }
          patients.value = temp;
        }
      });
    } on FirebaseException catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.message.toString());
    }
  }
}
