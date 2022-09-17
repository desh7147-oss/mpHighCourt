import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hcabaj/Networking/GetGreeingsMessage.dart';
import 'package:hcabaj/Screens/AboutUs.dart';
import 'package:hcabaj/Screens/ContactUs.dart';
import 'package:hcabaj/Screens/ExecutiveBody.dart';
import 'package:hcabaj/Screens/Gallery.dart';
import 'package:hcabaj/Screens/Gallery_webview.dart';
import 'package:hcabaj/Screens/GreetigsScreen.dart';
import 'package:hcabaj/Screens/History.dart';
import 'package:hcabaj/Screens/HomeScreen.dart';
import 'package:hcabaj/Screens/ProfileScreen.dart';
import 'package:hcabaj/Screens/global_webview_blogs.dart';
import 'package:hcabaj/Screens/loginScreen.dart';
import 'package:hcabaj/Screens/membersScreen.dart';
import 'package:hcabaj/Utils/Colors.dart';
import 'package:hcabaj/Utils/sharedPrefHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

// variables
final drawerItems = [
  "Home",
  "Members",
  "Contact",
  "About",
  "Executive Body",
  "Gallery",
  "History",
  "Latest News",
  "Send SMS"

  // "Edit Profile"
];

final drawerIcons = [
  Icons.home,
  Icons.people,
  Icons.contact_page_outlined,
  Icons.drive_file_rename_outline_sharp,
  Icons.person_outline_outlined,
  Icons.image,
  Icons.history_edu_sharp,
  FontAwesomeIcons.userEdit,
  Icons.image,
  Icons.mail
];

// Drawer
Widget buildCustomDrawer(BuildContext context, String currentScreen) {
  return Theme(
    data: Theme.of(context).copyWith(
      // Set the transparency here
      canvasColor: Colors.transparent.withOpacity(0.6),
    ),
    child: SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SharedPrefHelper.shared.getInt("isLoggedIn") != 1
                    ? Container(
                        color: Color(backGroundColor).withOpacity(0.5),
                        margin: const EdgeInsets.only(bottom: 30.0),
                        alignment: Alignment.centerLeft,
                        // color: Color(backGroundColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "lib/assets/HCABAJ-removebg-preview (1).png",
                                fit: BoxFit.fitWidth,
                                height: 70.0,
                                // width: 50.0,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              // alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.only(
                                  top: 0.0, left: 10, right: 10, bottom: 5.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10.0,
                                  side: BorderSide(
                                      width: 1.0, color: Colors.white),
                                  fixedSize: Size.fromWidth(
                                      MediaQuery.of(context).size.width / 2 -
                                          50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.5)),
                                  primary: Colors.transparent,
                                ),
                                onPressed: () async {
                                  SharedPreferences shared =
                                      await SharedPreferences.getInstance();
                                  shared.clear();
                                  shared.reload();
                                  print(
                                      "value: ${SharedPrefHelper.shared.getInt("isLoggedIn")}");
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }));
                                },
                                child: Text(
                                  "SIGN IN",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        color: Color(backGroundColor).withOpacity(0.5),
                        margin: const EdgeInsets.only(bottom: 30.0),
                        alignment: Alignment.centerLeft,
                        // color: Color(backGroundColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor:
                                    Color(backGroundColor).withOpacity(0.7),
                                radius: 30.0,
                                child: Image.asset(
                                  "lib/assets/HCABAJ-removebg-preview (1).png",
                                  fit: BoxFit.fitWidth,
                                  height: 70.0,
                                  // width: 50.0,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0),
                                child: Text(
                                  SharedPrefHelper.shared.getString("name") !=
                                          null
                                      ? SharedPrefHelper.shared
                                          .getString("name")
                                          .toString()
                                      : "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                SharedPrefHelper.shared.getString("email") !=
                                        null
                                    ? SharedPrefHelper.shared
                                        .getString("email")
                                        .toString()
                                    : "",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              // alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.only(
                                  top: 0.0, left: 10, right: 10, bottom: 5.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10.0,
                                  side: BorderSide(
                                      width: 1.0, color: Colors.white),
                                  fixedSize: Size.fromWidth(
                                      MediaQuery.of(context).size.width / 2 -
                                          50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.5)),
                                  primary: Colors.transparent,
                                ),
                                onPressed: () async {
                                  SharedPrefHelper.shared.clear();
                                  SharedPrefHelper.clear();
                                  print(
                                      "value: ${SharedPrefHelper.shared.getInt("isLoggedIn")}");
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                  }));
                                },
                                child: Text(
                                  SharedPrefHelper.shared
                                                  .getInt("isLoggedIn") !=
                                              null &&
                                          SharedPrefHelper.shared
                                                  .getInt("isLoggedIn") !=
                                              1
                                      ? "SIGN IN"
                                      : "SIGN OUT",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ListView.builder(
                    itemCount: drawerItems.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      print(
                          "role: ${SharedPrefHelper.shared.getString("role").toString()}");
                      return Center(
                        child: Column(
                          children: [
                            Visibility(
                              visible: drawerItems[index].toLowerCase() ==
                                          "send sms" &&
                                      SharedPrefHelper.shared
                                              .getString("role")
                                              .toString()
                                              .toLowerCase() !=
                                          "administrator"
                                  ? false
                                  : true,
                              child: Container(
                                // color: Colors.transparent,
                                height: 50.0,
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  onTap: () async {
                                    List<String> occasions = [];
                                    if (drawerItems[index] == "Send SMS") {
                                      try {
                                        final results = await Future.wait(
                                            [MessageHandling.getOccasions()]);
                                        occasions = results[0];
                                      } catch (e) {}
                                    }
                                    if (currentScreen == drawerItems[index])
                                      return null;
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        switch (drawerItems[index]) {
                                          case "Home":
                                            return HomeScreen();

                                          case "Members":
                                            return MembersScreen();

                                          case "Contact":
                                            return ContactScreen();

                                          case "About":
                                            return AboutScreen();
                                            break;

                                          case "Executive Body":
                                            return ExecutiveBodyScreen();

                                          case "Gallery":
                                            return GalleryScreen();

                                          case "History":
                                            return HistoryScreen();

                                          case "My Profile":
                                            return ProfileScreen(
                                              currentScreen: "My Profile",
                                            );

                                          case "Edit Profile":
                                            return ProfileScreen(
                                              currentScreen: "Edit Profile",
                                            );

                                          case "galleryWebView":
                                            return GalleryWebView(
                                                currentScreen:
                                                    "galleryWebView");

                                          case "Latest News":
                                            return GlobalWebViewBlog(
                                                currentScreen: "Latest News");

                                          case "Send SMS":
                                            return GreetingsScreen(occasions);

                                          default:
                                            return HomeScreen();
                                        }
                                      }),
                                    );
                                  },
                                  title: Container(
                                    // transform: Matrix4.translationValues(-35.0, 0, 0),
                                    child: Text(
                                      drawerItems[index],
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  leading: Icon(drawerIcons[index],
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            // Divider(
                            //   thickness: 0.0,
                            //   color: Colors.white,
                            // ),
                          ],
                        ),
                      );
                    }),

                // LOGOUT
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
