
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:physician/Models/ChatModel.dart';
import 'package:physician/Models/PatientModel.dart';
import 'package:physician/Models/WaitingroomModel.dart';

class AllChatsController extends GetxController
{
  String myid=FirebaseAuth.instance.currentUser!.uid;
  var isLoading=false.obs;
  var patients=<Patient>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadChats();
  }

  Future _loadChats()async
  {
    List<String> ids=[];
    try{
      final ref=FirebaseDatabase.instance.ref("chat");
      final patRef=FirebaseDatabase.instance.ref("patient");
      ref.onValue.listen((event)async {
        patients.clear();
        for(DataSnapshot snapshot in event.snapshot.children)
          {
            var model=chatModelFromJson(jsonEncode(snapshot.value));
            if(model.sid==myid)
              {
                ids.add(model.rid);
                print("reciever id");
              }
            else if(model.rid==myid)
              {
                ids.add(model.sid);
              }
          }
        for(String id in ids.toSet().toList())
          {
            var data=await patRef.child(id).once();
            if(data.snapshot.value!=null)
              {
                var model=patientModelFromJson(jsonEncode(data.snapshot.value));
                var patient=Patient(name: model.name, id: model.id, pic: model.pic);
                patients.add(patient);
              }
          }
      });
    }catch(e)
    {

    }
  }
}