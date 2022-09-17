import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

class AboutScreen extends StatelessWidget {
  // variables
  final currentScreen = "About";
  final executiveMembers = [
    "President - Mr. Manoj Sharma",
    "Vice President - Mr. Kuldeep Singh",
    "Secretary - Mr. Harpreet Singh Ruprah",
    "Joint Secretary - Mr. Akhil Singh",
    "Treasurer - Mr. Swapnil Ganguly",
    "Library Secretary - Mr. Vikram Singh",
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: buildGlobalAppBarWidget(context),
        body: _createAboutUsBody(context),
        drawer: buildCustomDrawer(context, "About"),
        bottomNavigationBar: customBottomNavigationBar(context),
      ),
    );
  }

  // about us body
  Widget _createAboutUsBody(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 270.0,
                  // child: Image.asset("lib/assets/club-auction-law-2492013.jpeg",
                  //     fit: BoxFit.cover),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "lib/assets/club-auction-law-2492013.jpeg",
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.hardLight),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  transform: Matrix4.translationValues(0.0, -15, 0),
                  child: Text(
                    "KNOW ABOUT US?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "ABOUT US",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              width: 70.0,
              child: Divider(
                color: Colors.red,
                thickness: 3,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text(
                "We are High Court Advocates’ Bar Association of Jabalpur Madhya Pradesh.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    decorationThickness: 10.0,
                    fontFamily: "Roboto"),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                """Established in the year 2006, High Court Advocates’ Bar Association is a society of actively practicing Advocates at the Principal Bench at Jabalpur of the High Court of Madhya Pradesh duly registered on 04.12.2006 under the Societies Registration Act 1763 (1973/No.44).""",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    decorationThickness: 10.0),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Image.asset(
                  "lib/assets/hammer-horizontal-court-802296-1024x768.jpg",
                  fit: BoxFit.cover,
                  height: 300.0),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Text(
                "Know More",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              width: 70.0,
              child: Divider(
                color: Colors.red,
                thickness: 3,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text(
                """In our Association have many experienced advocates who have help you in your law career, By the help of this site you can easily search our members and get there basic details from our Members section of this website. And members are able to create or edit there profile for update ourselves.""",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    decorationThickness: 10.0,
                    fontFamily: "Roboto"),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "Any query for membership you can connect with us by Email or WhatsApp mention in contact us page.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    decorationThickness: 10.0,
                    fontFamily: "Roboto"),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Text(
                "Executive bodies",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              width: 70.0,
              child: Divider(
                color: Colors.red,
                thickness: 3,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text(
                "This is registered and certified association by Madhya Pradesh society Registration and its operate by some executive bodies",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    decorationThickness: 10.0,
                    fontFamily: "Roboto"),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: executiveMembers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      child: Text(
                        " ${executiveMembers[index]}",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                            decorationThickness: 10.0,
                            fontFamily: "Roboto"),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }
}
