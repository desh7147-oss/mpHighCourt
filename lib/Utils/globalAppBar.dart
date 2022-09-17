import 'package:flutter/material.dart';
import 'package:hcabaj/Screens/HomeScreen.dart';
import 'package:hcabaj/Utils/Colors.dart';

buildGlobalAppBarWidget(BuildContext context,
    {String? screenSource = "", bool isFromPaymentScreen: false}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(70.0),
    child: AppBar(
      iconTheme: IconThemeData(size: 50.0),
      backgroundColor: Color(backGroundColor),
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(8.0, 12.0, 10.0, 8.0),
            height: 50.0,
            color: Colors.redAccent,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white, size: 20.0),
              onPressed: () {
                Scaffold.of(context).openDrawer();
                return null;
              },
            ),
          );
        },
      ),
      // elevation: 80.0,
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 10.0),
          // height: 400.0,
          // height: double.infinity,
          // width: double.infinity,
          child: InkWell(
            child: Image.asset("lib/assets/HCABAJ-removebg-preview (1).png",
                height: 50.0,
                // width: 50.0,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover),
            onTap: () {
              if (!isFromPaymentScreen) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                }), (Route<dynamic> route) => false);
              }
            },
          ),
        ),
      ],
    ),
  );
}
