import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:physician/CustomWidgets/LoadingScreen.dart';
import 'package:physician/Models/PatientModel.dart';
import 'package:physician/Models/RequestModel.dart';
import 'package:physician/Views/Home.dart';

class OnAccept extends StatefulWidget {
  RequestModel _model;

  OnAccept(this._model);

  @override
  State<OnAccept> createState() => _OnAcceptState();
}

class _OnAcceptState extends State<OnAccept> {
  var _lightGreen = Color(0xffCDE0C9);

  bool isLoading =false;

  String time="";

  String date="";

  @override
  Widget build(BuildContext context) {
    return isLoading ? LoadingScreen() : Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _lightGreen,
        title: const Text("Request",style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: _lightGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children:  [
                 ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(widget._model.pic),
                  ),
                  title: Text(widget._model.name,style:TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("Reason:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(widget._model.reason),
                ),
                SizedBox(height: 20,),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("Appointment Date and Time:",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    decoration: InputDecoration(
                      hintText: "pick time&date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid,
                          )
                      ),
                    ),
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date',
                    onChanged: (val){
                      time=val.split(" ").last;
                      date=val.split(" ").first;
                     print(val);
                    },
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    // onSaved: (val) => print(val),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width-40,
                  child: Row(

                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: RaisedButton(onPressed: ()async{
                           await _acceptRequest();
                          },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child:  Text("Accept",style: TextStyle(color: Colors.white),),
                            color: Colors.green.shade400,

                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: RaisedButton(onPressed: (){
                            final a_ref=FirebaseDatabase.instance.ref("appointments");
                            try{
                              a_ref.child(widget._model.id).child(FirebaseAuth.instance.currentUser!.uid).remove();
                              Get.snackbar("success", "request declined");
                              Get.off(()=>Homepage());
                            }catch(e)
                            {
                              Get.snackbar("Error", e.toString());
                            }
                          },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child:  Text("Decline",style: TextStyle(color: Colors.white),),
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _acceptRequest()async
  {
    try{
      isLoading=true;
      setState(() {

      });
      final ref=FirebaseDatabase.instance.ref("room");
      final a_ref=FirebaseDatabase.instance.ref("appointments");
      if(date.isEmpty || time.isEmpty)
        {
          Get.snackbar("info", "please pick date and time for appointment");
        }
      else
        {
          await ref.push().set(
              {
                'id':widget._model.id,
                'pid':FirebaseAuth.instance.currentUser!.uid,
                'date':date,
                'time':time,
              }

          );
          await a_ref.child(FirebaseAuth.instance.currentUser!.uid).child(widget._model.id).remove();
          Get.snackbar("success", "appointment successfull");
          Get.off(Homepage());
        }
      isLoading=false;
      setState(() {

      });
    }catch(e)
    {
      isLoading=false;
      setState(() {
      });
      Get.snackbar("Error", e.toString());
    }
  }
}
