import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physician/Controllers/LoginController.dart';
import 'package:physician/CustomWidgets/LoadingScreen.dart';
import 'package:physician/Views/Home.dart';
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color _mainColor= Color(0xff68B280);
  Color _btnColor2= Color(0xff329D9C);
  bool ispassVisible=false;

  bool validEmail=false;

  final emailtxt=TextEditingController();

  final passtxt=TextEditingController();

  var c=Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (controler) {
        return controler.isLoading.isTrue ? LoadingScreen() :Scaffold(
          appBar:AppBar(
            elevation: 0,
          ) ,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _logo(context),
                _myField(context,"Email",false,emailtxt),
                _myField(context,"Password",ispassVisible,passtxt),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: Text(
                    "Forgot password",
                    style: TextStyle(fontSize: 18,color: _btnColor2),
                  ),
                ),
                _LoginButton(context,controler)
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _logo(BuildContext context)
  {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal:10),
      height: MediaQuery.of(context).size.height*0.2,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/logo.png")
          )
      ),
    );
  }

  Widget _LoginButton(BuildContext context,LoginController controler)
  {
    var shape=RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
    return Material(
      elevation: 10,
      shape: shape,
      shadowColor: _mainColor,
      child: GestureDetector(
        onTap: ()async{
          await controler.Login(emailtxt.text, passtxt.text);
        },
        child: Container(
          width: MediaQuery.of(context).size.width*0.7,
          height: 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // _btnColor1,
                _mainColor,
                _btnColor2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Log in".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _myField(BuildContext context,String hint,bool ispass,var controller)
  {
    var shape=RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width*0.8,
      child: Material(
        color: Colors.white,
        elevation: 10,
        shape: shape,
        shadowColor: _mainColor,
        child: TextField(
          onChanged: hint.toLowerCase()!="email"? (val){}:(value){
            String p=r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = new RegExp(p);
            if(regExp.hasMatch(value))
              {
                validEmail=true;
              }
            else {
              validEmail = false;
              print(value);
            }
            setState(() {

            });
          },
          obscureText: ispass,
          controller: controller,

          decoration: InputDecoration(
            suffixIcon: hint.toLowerCase()=="email" ?Icon(Icons.check_circle ,color: validEmail ? _mainColor: Colors.grey.withOpacity(0.7),size: 30,) : IconButton(onPressed: (){
              if(ispassVisible)
                ispassVisible=false;
              else
                ispassVisible=true;
              setState(() {

              });
            },icon: Icon(ispassVisible?CupertinoIcons.eye_slash : CupertinoIcons.eye,color: Colors.grey.withOpacity(0.7),size: 30,)),
            contentPadding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                    style: BorderStyle.none
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                    style: BorderStyle.none
                )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 0,
                style: BorderStyle.none
              )
            ),
            hintText: hint,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7))
          ),
        ),
      ),
    );
  }
}
