import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hcabaj/Authorization/AuthorizationPostApis.dart';
import 'package:hcabaj/Screens/HomeScreen.dart';
import 'package:hcabaj/Utils/Colors.dart';
import 'package:hcabaj/Utils/ReusableWidgets.dart';
import 'package:hcabaj/Utils/sharedPrefHelper.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // variables
  Map<String, String> userDetailsMap = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _m_userNameController = TextEditingController();
  var _m_passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SharedPrefHelper.shared.clear();
        SharedPrefHelper.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => HomeScreen()),
            (route) => false);
        return true;
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(backGroundColor),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 70.0, bottom: 60.0),
                    child: Image.asset(
                      "lib/assets/HCABAJ-removebg-preview (1).png",
                      fit: BoxFit.cover,
                    ),
                  ),

                  // UserName / Email
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 120,
                      maxWidth: MediaQuery.of(context).size.width - 50,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.bottom,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          contentPadding: const EdgeInsets.only(
                            top: 18.0,
                            bottom: 8.0,
                          ),
                          labelText: "Username / Email",
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          helperText: "Enter your Username or Email here",
                          helperStyle:
                              TextStyle(color: Colors.white60, fontSize: 12.0),
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                                style: BorderStyle.solid),
                          ),
                        ),
                        validator: (String? username) {
                          if (username == null ||
                              username == " " ||
                              username.isEmpty) {
                            return ("Username can not be empty");
                          } else {
                            print("username is: ${username}");
                            userDetailsMap["user"] = username;
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 120,
                      maxWidth: MediaQuery.of(context).size.width - 50,
                    ),

                    // password
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          contentPadding:
                              const EdgeInsets.only(top: 18.0, bottom: 8.0),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          helperText: "Enter your Password here",
                          helperStyle:
                              TextStyle(color: Colors.white60, fontSize: 12.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        validator: (String? password) {
                          if (password == null ||
                              password == " " ||
                              password.isEmpty) {
                            return ("Password can not be empty");
                          } else {
                            // print("password is: ${password}");
                            userDetailsMap["password"] = password;
                            return null;
                          }
                        },
                      ),
                    ),
                  ),

                  // forgot password
                  Container(
                    alignment: Alignment.centerLeft,
                    transform: Matrix4.translationValues(0, -10, 0),
                    width: MediaQuery.of(context).size.width - 50,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: TextButton(
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      onPressed: () {
                        print("forgot hahahaha");
                      },
                    ),
                  ),

                  // login button
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orange.shade300),
                      fixedSize: MaterialStateProperty.all(
                        Size.fromWidth(MediaQuery.of(context).size.width - 150),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() == true) {
                        print("okay");
                        AuthorizationGetApi.loginPostApi(userDetailsMap)
                            .then((value) {
                          if (value != null &&
                              value.status != null &&
                              value.status == "1" &&
                              value.msg == "login success") {
                            print("success");
                            ScaffoldMessenger.of(context).showSnackBar(
                                ReusableWidgets.getSnackBar(
                                    context,
                                    'Successfully authenticated',
                                    Color(0xff00A86B)));
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return HomeScreen();
                              }), (route) => false);
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                ReusableWidgets.getSnackBar(context,
                                    'Invalid credentials', Colors.redAccent));
                          }
                        });
                      }
                    },
                    child: Text("LOGIN"),
                  ),

                  // signup text
                  Visibility(
                    visible: false,
                    child: Container(
                      transform: Matrix4.translationValues(0, -8.0, 0),
                      width: MediaQuery.of(context).size.width - 80,
                      child: TextButton(
                        child: Text(
                          "Not an existing user? SIGNUP here",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          print("signing up");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
