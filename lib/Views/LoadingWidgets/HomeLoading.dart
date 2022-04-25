import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physician/Controllers/LoginController.dart';
import 'package:physician/Views/drawers.dart';
import 'package:skeletons/skeletons.dart';

class HomeLoading extends StatefulWidget {
  @override
  State<HomeLoading> createState() => _HomeLoadingState();
}

class _HomeLoadingState extends State<HomeLoading> {
  var _lightGreen=Color(0xffCDE0C9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _lightGreen,
        elevation: 0,
        leading: Builder(builder: (context){
          return IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon:SvgPicture.asset("assets/menu.svg") );
        }),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration:BoxDecoration(
                color: _lightGreen,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
              ) ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: 30),
                      child: _profilePic()
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                    child: Text(model.value.name,style: TextStyle(color: Color(0xff205072), fontSize: 22,fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),

            CardWidget('Patients History'),
            CardWidget('Waiting Room'),
          ],
        ),
      ),
    );
  }

  Widget _profilePic()
  {
    return Stack(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/user.jpg"),
                  fit: BoxFit.fill
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4,
                style: BorderStyle.solid,
              )
          ),
        ),

        Positioned(
          bottom: 5,
          right: 0,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                  style: BorderStyle.solid,
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget InnerWidget(String _title, String _date) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SkeletonListTile(
        hasSubtitle: true,
        leadingStyle: SkeletonAvatarStyle(
          shape: BoxShape.circle
        ),
        titleStyle: SkeletonLineStyle(
          height: 20,
          width: MediaQuery.of(context).size.width*0.35,
          borderRadius: BorderRadius.circular(20)
        ),
        subtitleStyle: SkeletonLineStyle(
            height: 10,
            width: MediaQuery.of(context).size.width*0.2,
            borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }

  CardWidget(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: const Color(0xffCDE0C9),
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Color(0xff205072),
                      fontWeight: FontWeight.w800,
                      fontSize: 22),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InnerWidget('Patient Name 1', 'Date 01-01-2022'),
            InnerWidget('Patient Name 2', 'Date 02-01-2022'),
            ButtonBar(
              children: <Widget>[
                SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 40,
                        width: 80,
                        borderRadius: BorderRadius.circular(30)
                    )
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
