
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:physician/Models/RequestModel.dart';

class RequestController extends GetxController
{
  var requests=<RequestModel>[].obs;
  var isLoading=false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getRequests();
  }

  Future _getRequests()async
  {
    List<RequestModel> temp=[];
    try{
      isLoading.value=true;
      final ref=FirebaseDatabase.instance.ref("appointments");
      ref.child(FirebaseAuth.instance.currentUser!.uid).onValue.listen((event) {
        temp.clear();
        requests.clear();
        for(DataSnapshot snapshot in event.snapshot.children)
        {
          requests.add(requestModelFromJson(jsonEncode(snapshot.value)));
        }
        print("request refreshed");
      });
      isLoading.value=false;

    }catch(e)
    {
      isLoading.value=false;
      Get.snackbar("Error", e.toString());
    }
  }
}