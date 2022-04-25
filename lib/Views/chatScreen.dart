import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physician/Models/WaitingroomModel.dart';

import '../Controllers/ChatController.dart';
import '../CustomWidgets/LoadingScreen.dart';
import '../Models/ChatModel.dart';
import '../Models/PatientModel.dart';

class ChatScreen extends StatelessWidget {
  final txtMsg=TextEditingController();

  var _lightGreen = Color(0xffCDE0C9);
  var scrollController=ScrollController();
  String myid=FirebaseAuth.instance.currentUser!.uid;
  Patient reciever;
  ChatScreen(this.reciever);
  @override
  Widget build(BuildContext context) {
    var _c=Get.put(ChatController(reciever.id));
    return Scaffold(
      backgroundColor: _lightGreen,
      appBar: AppBar(

        backgroundColor: _lightGreen,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(
              reciever.pic,
            )
            ),
            SizedBox(width:10),

            Text(reciever.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(onPressed: (){

            }, icon: Icon(Icons.videocam,color: Color(0xff329D9C),)),
          )
        ],
      ),

      body:GetX<ChatController>(
        builder: (controller) {
          if(controller.isLoading.isTrue)
            return LoadingScreen();
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemCount: controller.Messages.length,
                    itemBuilder: (context,index){
                      return controller.Messages[index].sid==myid ? Sender(controller.Messages[index]) : Reciever(controller.Messages[index]);
                    },
                  ),
                ),
                Row(
                  children: [

                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                        decoration: BoxDecoration(

                          borderRadius:const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child:
                        TextField(
                          controller: txtMsg,
                          decoration: const InputDecoration(hintText: "Message",
                            border: InputBorder.none,
                          ),
                          minLines: 1,maxLines: 5,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: ()async{
                        await sendMessage(reciever.id, txtMsg.text);
                        txtMsg.clear();
                        scrollController.jumpTo(0);
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration:const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: Icon(Icons.send,color: Colors.white,)
                      ),
                    ),
                  ],
                ),
              ]
          );
        }
      ),


    );
  }
  Widget Reciever(ChatModel model)
  {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(right: 50,left: 10,top: 10,bottom: 15),

        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child:
        Column(
          //crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child:
                Text(model.msg),
              ),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child:
                Text(model.dt,style:TextStyle(color: Colors.grey)),
              ),
            )
          ],
        ),

      ),
    );
  }
  Widget Sender(ChatModel model)
  {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(right: 10,left: 50,top: 10,bottom: 15),

        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          color: Color(0xff329D9C),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child:Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [Align(
              alignment: Alignment.topLeft,
              child: Container(
                child:Text(model.msg,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                child:
                Text(model.dt,style:TextStyle(color: Colors.white60)),
              ),
            )
          ],
        ),

      ),
    );
  }

  Future sendMessage(String rid,String msg)async
  {
    String sid=FirebaseAuth.instance.currentUser!.uid;
    String date=DateTime.now().toString().split(" ").first;
    String time=DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();
    try{
      final ref=FirebaseDatabase.instance.ref("chat");
      ref.push().set(
          {
            "msg":msg,
            "sid":sid,
            "rid":rid,
            "dt":date+" "+time,
          }
      );
    }catch(e)
    {
      Get.snackbar("Error", e.toString());
    }
  }
}