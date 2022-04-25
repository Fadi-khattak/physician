import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physician/Controllers/WaitingRoomController.dart';
import 'package:physician/Models/PatientModel.dart';
import 'package:physician/Models/WaitingroomModel.dart';
import 'package:physician/Views/CallScreen.dart';
import 'package:physician/Views/chatScreen.dart';

class WaitingRoom extends StatelessWidget {
  var _textColor = const Color(0xff205072);
  var c=Get.put(WaitingRoomController());

  var lightGreen = Color(0xffCDE0C9);
  Color mainColor = Color(0xff68B280);
  @override
  Widget build(BuildContext context) {
    return GetX<WaitingRoomController>(
        builder: (controller) {
          if(controller.isLoading.isTrue)
            return CircularProgressIndicator();
      return Scaffold(
        backgroundColor: lightGreen,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Waiting Room",
            style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: controller.isLoading.isTrue
            ?  const Center(child:CircularProgressIndicator()) 
            :ListView.builder(
                itemCount: controller.roomPatient.length,
                itemBuilder: (context, index) {
                  return roomPatientCard(controller.roomPatient[index]);
                })
      );
    });
  }

  Widget roomPatientCard(WaitingroomModel model) {
    return Card(
      color: Colors.white.withOpacity(0.5),
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: SizedBox(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage(model.patient.pic),
            )),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        title: Text(
          model.patient.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Expanded(
                child: RaisedButton(
              onPressed: () {
                Get.to(()=>ChatScreen(model.patient));
              },
              child: const Text("chat", style: TextStyle(color: Colors.white)),
              color: mainColor,
            )),
            const SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                  onPressed: () {
                    try{
                      final ref=FirebaseDatabase.instance.ref("room");
                      ref.child(model.key).remove();


                    }catch(e)
                    {
                      Get.snackbar("Error", e.toString());
                    }
                  },
                  child: Text(
                    "Remove",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: mainColor),
            )
          ],
        ),
      ),
    );
  }
}
