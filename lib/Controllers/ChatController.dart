
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../Models/ChatModel.dart';

class  ChatController extends GetxController
{
  var isLoading=false.obs;
  var Messages=<ChatModel>[].obs;
  String myid=FirebaseAuth.instance.currentUser!.uid;
  String reciverid;

  ChatController(this.reciverid);
  @override
  onInit()
  {
    super.onInit();
    _getMessages();
  }

  Future _getMessages()async
  {
    List<ChatModel> temp=[];
    try{
      final ref=FirebaseDatabase.instance.ref("chat");
      ref.onValue.listen((event) {
        temp.clear();
        Messages.clear();
       for(DataSnapshot snapshot in event.snapshot.children)
         {
           ChatModel model=chatModelFromJson(jsonEncode(snapshot.value));
           if((model.sid==myid || model.rid==myid) && (model.sid==reciverid || model.rid==reciverid))
             {
               temp.add(model);
             }
         }
       Messages.addAll(temp.reversed.toList());
       print(temp.last.msg);


      });
    }catch(e)
    {
      Get.snackbar("Error", e.toString());
    }
  }



}