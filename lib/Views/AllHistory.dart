import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physician/Controllers/HistoryController.dart';
import 'package:physician/Controllers/WaitingRoomController.dart';
import 'package:physician/CustomWidgets/LoadingScreen.dart';
import 'package:physician/Models/PatientModel.dart';

class AllHistory extends StatelessWidget {
  var _textColor = const Color(0xff205072);
  var c=Get.put(HistoryController());

  var lightGreen = Color(0xffCDE0C9);
  Color mainColor = Color(0xff68B280);
  @override
  Widget build(BuildContext context) {
    return GetX<HistoryController>(
        builder: (controller) {
          if(controller.isLoading.isTrue)
            return LoadingScreen();
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
                itemCount: controller.patients.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white.withOpacity(0.7),
                    child: ListTile(
                      leading:  SizedBox(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(controller.patients[index].pic),
                        ),
                      ),
                      title: Text(
                        controller.patients[index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(controller.patients[index].history!.entries.last.value.date),
                    ),
                  );
                }),
          );
        });
  }
}
