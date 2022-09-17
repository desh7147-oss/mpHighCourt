import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcabaj/Screens/HomeScreen.dart';
import 'package:hcabaj/Screens/ProfileScreen.dart';
import 'package:hcabaj/Screens/loginScreen.dart';
import 'package:hcabaj/Utils/BasePaths.dart';
import 'package:hcabaj/Utils/Colors.dart';
import 'package:hcabaj/Utils/ReusableWidgets.dart';
import 'package:hcabaj/Utils/sharedPrefHelper.dart';

Widget customBottomNavigationBar(BuildContext context,
    {String screenSource = ""}) {
  return Theme(
    data: Theme.of(context).copyWith(
      // sets the background color of the `BottomNavigationBar`
      canvasColor: Color(backGroundColor),
      // sets the active color of the `BottomNavigationBar` if `Brightness` is light
      primaryColor: Colors.white,
      textTheme: Theme.of(context).textTheme.copyWith(
            caption: new TextStyle(color: Colors.white),
          ),
    ),
    child: SizedBox(
      height: 75,
      child: BottomNavigationBar(
        backgroundColor: Color(backGroundColor),
        currentIndex: 0,
        elevation: 1.0,
        iconSize: 22,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        // unselectedLabelStyle: TextStyle(color: Colors.white),
        items: screenSource == "My Profile"
            ? [
                BottomNavigationBarItem(
                    // label: 'Home',
                    backgroundColor: Color(backGroundColor),
                    icon: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 26.0,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        if (screenSource != "home page") {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    label: ""),
                // Home Button
                BottomNavigationBarItem(
                    // label: 'Home',
                    backgroundColor: Color(backGroundColor),
                    icon: IconButton(
                      icon: Icon(Icons.home_outlined, size: 35.0),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeScreen();
                        }));
                      },
                    ),
                    label: ""),
              ]
            : screenSource == "Home"
                ? [
                    BottomNavigationBarItem(
                        // label: 'Home',
                        backgroundColor: Color(backGroundColor),
                        icon: IconButton(
                          icon: Icon(Icons.home_outlined, size: 35.0),
                          color: Colors.white,
                          onPressed: () {
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) {
                            //   return HomeScreen();
                            // }));
                            return null;
                          },
                        ),
                        label: ""),
                    BottomNavigationBarItem(
                      label: "",
                      icon: Container(
                        height: 0,
                        width: 0,
                      ),
                    ),
                    // My Profile button
                    BottomNavigationBarItem(
                        icon: IconButton(
                          icon: Icon(
                            Icons.person_outlined,
                            size: 36.0,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            if (SharedPrefHelper.shared.getInt("isLoggedIn") ==
                                1) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ProfileScreen(
                                  currentScreen: "My profile",
                                );
                              }));
                            } else {
                              snackbarKey.currentState?.showSnackBar(
                                  ReusableWidgets.getSnackBar(
                                      context,
                                      "You are not logged in, Kindly login first.",
                                      Colors.redAccent));
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginScreen();
                              }));
                            }
                          },
                        ),
                        label: ""),
                    // back button
                    // BottomNavigationBarItem(
                    //     // label: 'Home',
                    //     backgroundColor: Color(backGroundColor),
                    //     icon: Visibility(
                    //       visible: screenSource == "Home" ? false : true,
                    //       child: IconButton(
                    //         icon: Icon(Icons.arrow_back_ios),
                    //         color: Colors.white,
                    //         onPressed: () {
                    //           if (screenSource != "Home") {
                    //             Navigator.pop(context);
                    //           }
                    //         },
                    //       ),
                    //     ),
                    //     title: Visibility(
                    //       visible: screenSource == "Home" ? false : true,
                    //       child: Text(
                    //         "Back",
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     )),
                  ]
                : [
                    // back button
                    BottomNavigationBarItem(
                        // label: 'Home',
                        backgroundColor: Color(backGroundColor),
                        icon: IconButton(
                          icon: Icon(Icons.arrow_back_ios, size: 26.0),
                          color: Colors.white,
                          onPressed: () {
                            if (screenSource != "Home") {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        label: ""),

                    // Home Button
                    BottomNavigationBarItem(
                        // label: 'Home',
                        backgroundColor: Color(backGroundColor),
                        icon: IconButton(
                          icon: Icon(Icons.home_outlined, size: 35.0),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                          },
                        ),
                        label: ""),

                    // My Profile button
                    BottomNavigationBarItem(
                      icon: IconButton(
                        icon: Icon(
                          Icons.person_outlined,
                          size: 36,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          if (SharedPrefHelper.shared.getInt("isLoggedIn") ==
                              1) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfileScreen(
                                currentScreen: "My profile",
                              );
                            }));
                          } else {
                            snackbarKey.currentState?.showSnackBar(
                                ReusableWidgets.getSnackBar(
                                    context,
                                    "You are not logged in, Kindly login first.",
                                    Colors.redAccent));
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          }
                        },
                      ),
                      label: "",
                    ),
                  ],
      ),
    ),
  );
}
