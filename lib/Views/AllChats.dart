import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physician/CustomWidgets/LoadingScreen.dart';
import 'package:physician/Views/chatScreen.dart';

import '../Controllers/AllChatsController.dart';

class AllChats extends StatelessWidget {
   AllChats({Key? key}) : super(key: key);
   var lightGreen = Color(0xffCDE0C9);
   Color _btnColor2= Color(0xff329D9C);
   var _c=Get.put(AllChatsController());
   List<String> name=["inDriver","Masti","Careem"];
   List<String> msg=["Your verification code is 38947593...","Ja ja tur ja.","Your verfification code is 34534354..."];
   List<String> pic=["https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Logo_inDriver.svg/1200px-Logo_inDriver.svg.png",
              "https://image.winudf.com/v2/image1/Y29tLm1hc3RpLm11c2ljdGljdG9rX3NjcmVlbl8wXzE1OTc3NjQwNTZfMDE4/screen-0.jpg?fakeurl=1&type=.jpg",
              "https://www.careem.com/images/careem-white-wink.jpg",

         ];
   List<String> time=["12:30","2:46","yesterday"];
  @override
  Widget build(BuildContext context) {
    return GetX<AllChatsController>(
      builder: (controller) {
        if(controller.isLoading.isTrue)
          return LoadingScreen();
        return Scaffold(
          backgroundColor: lightGreen,
          appBar: AppBar(
            backgroundColor: lightGreen,
            title: Text("Chats",style: TextStyle(color: Colors.black),),
          ),
          body:ListView.builder(
            itemCount: controller.patients.length,
            itemBuilder: (context, index) {
              return  Card(
                color: _btnColor2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onTap: (){
                    Get.to(()=>ChatScreen(controller.patients[0]));
                  },
                  contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                  title: Text(controller.patients[index].name,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),
                  subtitle: Text(msg[index],style: TextStyle(color: Colors.white60)),
                  trailing: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                          child: Text(time[index],style: TextStyle(color: Colors.white60),)
                      ),
                    ],
                  ),


                  leading:  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                        color: Colors.white,
                        image: DecorationImage(image: NetworkImage(controller.patients[index].pic,),
                          fit: BoxFit.fill,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      )
                  ),
                  dense: true,

                ),
              );
            }),
        );
      }
    );
  }
}
