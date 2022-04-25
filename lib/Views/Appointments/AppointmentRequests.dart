import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physician/Controllers/RequestController.dart';
import 'package:physician/CustomWidgets/LoadingScreen.dart';
import 'package:physician/Views/Appointments/OnAccept.dart';

class AppointmentRequests extends StatelessWidget {
  Color _mainColor= Color(0xff68B280);
  Color _btnColor2= Color(0xff329D9C);
  var _lightGreen = Color(0xffCDE0C9);
  var _c=Get.put(RequestController());
  @override
  Widget build(BuildContext context) {
    return GetX<RequestController>(
      builder: (controller) {
        if(controller.isLoading.isTrue)
          return LoadingScreen();
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: _lightGreen,
            title: Text("Appointment Requests",style: TextStyle(color: Colors.black),),
          ),
          body: Container(
            child: ListView.builder(
              itemCount: controller.requests.length,
              itemBuilder: (context,index) {
                return Card(
                  color: _lightGreen,
                  child: ListTile(
                    leading: SizedBox(
                      height: 50,
                        width: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(controller.requests[index].pic),
                      ),
                    ),
                    title: Text(controller.requests[index].name,style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(controller.requests[index].reason,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    trailing: Icon(Icons.keyboard_arrow_right_outlined),
                    onTap: (){
                      Get.to(()=>OnAccept(controller.requests[index]));
                    },
                  ),
                );
              }
            ),
          ),
        );
      }
    );
  }
}
