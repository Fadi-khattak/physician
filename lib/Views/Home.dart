import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physician/Controllers/HomeController.dart';
import 'package:physician/Controllers/LoginController.dart';
import 'package:physician/Models/PatientModel.dart';
import 'package:physician/Models/WaitingroomModel.dart';
import 'package:physician/Views/LoadingWidgets/HomeLoading.dart';
import 'package:physician/Views/PatientsHistory.dart';
import 'package:physician/Views/WaitingRoom.dart';
import 'package:physician/Views/drawers.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var _lightGreen = Color(0xffCDE0C9);

  var c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(builder: (_controller) {
      return _controller.isLoading.isTrue
          ? HomeLoading()
          : Scaffold(
              appBar: AppBar(
                backgroundColor: _lightGreen,
                elevation: 0,
                leading: Builder(builder: (context) {
                  return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: SvgPicture.asset("assets/menu.svg"));
                }),
              ),
              drawer: MyDrawer(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: _lightGreen,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 30),
                              child: _profilePic(_controller)),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 30),
                            child: Text(
                              model.value.name,
                              style: TextStyle(
                                  color: Color(0xff205072),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    WaitingCardWidget('Waiting Room', _controller.roomPatient),
                  ],
                ),
              ),
            );
    });
  }

  Widget _profilePic(HomeController controller) {
    return Stack(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(model.value.pic), fit: BoxFit.cover),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 4,
                style: BorderStyle.solid,
              )),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color:controller.physician.value.status==0 ?Colors.grey :Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                  style: BorderStyle.solid,
                )),
          ),
        ),
      ],
    );
  }

  Widget InnerWidget(String _title, String _date,String pic) {
    return ListTile(
      leading:  SizedBox(
        height: 50,
        width: 50,
        child: CircleAvatar(
          backgroundImage: NetworkImage(pic),
        ),
      ),
      title: Text(
        _title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(_date),
    );
  }

  CardWidget(String title, List<PatientModel> patientModel) {
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
            InnerWidget(patientModel[patientModel.length - 1].name,
                patientModel.last.history!.entries.last.value.date,patientModel[patientModel.length - 1].pic),
            InnerWidget(
                patientModel[patientModel.length - 2].name,
                patientModel[patientModel.length - 2]
                    .history!
                    .entries
                    .last
                    .value
                    .date,patientModel[patientModel.length - 2].pic),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff68B280),
                    shadowColor: const Color(0xff329D9C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                  ),
                  child: const Text(
                    'VIEW ALL',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Get.to(()=>PatientHistory());
                  },
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

  WaitingCardWidget(String title, List<WaitingroomModel> model) {
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
                  style: const TextStyle(
                      color: Color(0xff205072),
                      fontWeight: FontWeight.w800,
                      fontSize: 22),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            model.length < 1 ?Container(
              child: Text("No Patient in waiting room"),
            ) : Container(
              height: 200,
              child: ListView.builder(
                itemCount: model.length,
                itemBuilder: (context, index) {
                  return WaitingRoom().roomPatientCard(model[index]);
                },
              ),
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff68B280),
                    shadowColor: const Color(0xff329D9C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                  ),
                  child: const Text(
                    'VIEW ALL',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  onPressed: () {
                    Get.to(()=>WaitingRoom());
                  },
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
