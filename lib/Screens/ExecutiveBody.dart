import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

class ExecutiveBodyScreen extends StatelessWidget {
  // variables
  final currentScreen = "Executive Body";
  final executiveBodyMembers = [
    "lib/assets/ExecutivebodyMembers/President.png",
    "lib/assets/ExecutivebodyMembers/VicePresident.png",
    "lib/assets/ExecutivebodyMembers/Secretary.png",
    "lib/assets/ExecutivebodyMembers/JointSecretary.png",
    "lib/assets/ExecutivebodyMembers/Treasurer.png",
    "lib/assets/ExecutivebodyMembers/LibrarySecretary.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember1.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember2.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember3.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember4.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember5.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildGlobalAppBarWidget(context),
      body: _createExecutiveBody(context),
      drawer: buildCustomDrawer(context, "Executive Body"),
      bottomNavigationBar: customBottomNavigationBar(context),
    );
  }

  // body
  Widget _createExecutiveBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.0),
          Container(
              child: Text("Executive Body",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28.0,
                      letterSpacing: 2.0))),
          SizedBox(height: 5.0),
          Container(
            child: Text(
              "MEMBERS OF EXECUTIVE BODY",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            width: 40,
            child: Divider(
              color: Colors.red,
              thickness: 3.0,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 150,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: executiveBodyMembers.length,
                clipBehavior: Clip.antiAlias,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2),
                    ),
                    child: Image.asset(executiveBodyMembers[index],
                        height: 100, width: 100),
                  );
                }),
          ),
          SizedBox(
            height: 15.0,
          )
        ],
      ),
    );
  }
}
