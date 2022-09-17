import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

class HistoryScreen extends StatelessWidget {
  // variables
  final currentScreen = "History";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: buildGlobalAppBarWidget(context),
        body: _createHistoryBody(context),
        drawer: buildCustomDrawer(context, "History"),
        bottomNavigationBar: customBottomNavigationBar(context),
      ),
    );
  }

  // body
  Widget _createHistoryBody(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              alignment: Alignment.center,
              child: Text(
                "History",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Image.asset(
              "lib/assets/sssssss.png",
              height: 60.0,
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Text(
                "HIGH COURT ADVOCATES' BAR ASSOCIATION JABALPUR (M.P.)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  // letterSpacing: 1.0,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Text("PAST PRESIDENTS & SECRETARIES",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: 20.0,
              child: Divider(
                color: Colors.red,
                thickness: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    // left: 40.0,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "lib/assets/sssssss.png",
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.3),
                                BlendMode.colorBurn)),
                      ),
                    ),
                  ),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2),
                    },
                    border: TableBorder(
                      top: BorderSide(color: Colors.black, width: 2),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      right: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      horizontalInside:
                          BorderSide(color: Colors.black, width: 3),
                      verticalInside: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                    ),
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "SI",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "PRESIDENTS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "SECRETARIES",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Period",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text(""),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sarvshri",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Sarvshri",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Text(""),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "S.C Datt",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Manoj Sharma",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                              child: Text(
                                "5/4/2006-5/4/2008",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "2",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "R.P. Agrawal",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Manoj Sharma",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                              child: Text(
                                "5/4/2006-5/4/2008",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "3",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "T.S. Ruprah",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "V.K. Shukla",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                              child: Text(
                                "5/4/2006-5/4/2008",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "4",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "D.K. Dixit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Narendra Chauhan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FittedBox(
                            child: Text(
                              "5/4/2006-5/4/2008",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                        ),
                      ]),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "5",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "R.P. Agrawal",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "V.K. Shukla",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FittedBox(
                              child: Text(
                                "5/4/2006-5/4/2008",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "6",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "T.S. Ruprah",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Praveen Dubey",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Roboto",
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FittedBox(
                            child: Text(
                              "5/4/2006-5/4/2008",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 20.0,
                child: Divider(
                  color: Colors.red,
                  thickness: 3,
                )),
            Divider(
              color: Colors.black38,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
