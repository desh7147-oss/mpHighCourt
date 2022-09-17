import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hcabaj/Networking/EmailService.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/ReusableWidgets.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

class ContactScreen extends StatelessWidget {
  // variables
  final currentScreen = "Contact";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController message_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();
  final TextEditingController name_controller = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: buildGlobalAppBarWidget(context),
        body: _createBuildBodyWidget(context),
        drawer: buildCustomDrawer(context, "Contact"),
        bottomNavigationBar: customBottomNavigationBar(context),
      ),
    );
  }

  // body
  Widget _createBuildBodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
                "lib/assets/meeting-relationship-business-1019875.jpeg",
                height: 200.0),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(
                "CONTACT US",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 22),
              )),
          // SizedBox(height: 10.0),
          // Container(
          //   child: Text(
          //     "WE'RE READY, LET'S TALK.",
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 20.0,
          //         fontWeight: FontWeight.w600),
          //   ),
          // ),
          SizedBox(height: 30.0),
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 5.0),
                  child: SizedBox(
                    height: 65.0,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      maxLength: 40,
                      controller: name_controller,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        contentPadding: const EdgeInsets.only(
                          top: 18.0,
                          bottom: 18.0,
                          left: 10.0,
                        ),
                        // labelText: "Username / Email",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        // helperText: "Enter your Username or Email here",
                        hintText: "Name",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 20.0),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      validator: (String? username) {
                        if (username == null ||
                            username == " " ||
                            username.isEmpty) {
                          return ("Username can not be empty");
                        } else {
                          print("useraname is: ${username}");
                          return null;
                        }
                      },
                    ),
                    // TextFormField(),
                    // TextFormField(),
                    // ],
                  ),
                ),

                // Email Address
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 5.0),
                  child: SizedBox(
                    height: 65.0,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.bottom,
                      maxLength: 40,
                      maxLines: 1,
                      controller: email_controller,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        contentPadding: const EdgeInsets.only(
                          top: 18.0,
                          bottom: 18.0,
                          left: 10.0,
                        ),
                        // labelText: "Username / Email",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        // helperText: "Enter your Username or Email here",
                        hintText: "Email",
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 20.0),
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (String? username) {
                        if (username == null ||
                            username == " " ||
                            username.isEmpty) {
                          return ("Username can not be empty");
                        } else {
                          print("useraname is: ${username}");
                          return null;
                        }
                      },
                    ),
                    // TextFormField(),
                    // TextFormField(),
                    // ],
                  ),
                ),

                // Message
                Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 8.0, 0.0),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    maxLength: 250,
                    maxLines: 4,
                    controller: message_controller,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      contentPadding: const EdgeInsets.only(
                        top: 18.0,
                        bottom: 18.0,
                        left: 10.0,
                      ),
                      // labelText: "Username / Email",
                      // labelStyle: TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 20.0,
                      // ),
                      // helperText: "Enter your Username or Email here",
                      hintText: "Message",
                      hintStyle:
                          TextStyle(color: Colors.black54, fontSize: 20.0),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Send Message Button
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                fixedSize: MaterialStateProperty.all(
                  Size.fromHeight(50),
                ),
                shape: MaterialStateProperty.all(
                  StadiumBorder(
                      // borderRadius: BorderRadius.circular(10.0),
                      ),
                ),
              ),
              onPressed: () async {
                if (message_controller.text != null &&
                    email_controller.text != null &&
                    name_controller.text != null) {
                  String response = await sendAnEmail(message_controller.text,
                      email_controller.text, name_controller.text);
                  if (response.isNotEmpty) {
                    if (response == "success") {
                      message_controller.text = "";
                      name_controller.text = "";
                      email_controller.text = "";
                      _scaffoldKey.currentState!.showSnackBar(
                          ReusableWidgets.getSnackBar(context,
                              "Message sent successfully.", Colors.green));
                    } else {
                      _scaffoldKey.currentState!.showSnackBar(
                          ReusableWidgets.getSnackBar(context,
                              "Oops! something went wrong", Colors.redAccent));
                    }
                  }
                } else {
                  Scaffold.of(context).showSnackBar(ReusableWidgets.getSnackBar(
                      context,
                      "Kindly fill all the details.",
                      Colors.redAccent));
                }
              },
              child: Text("SEND MESSAGE",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      letterSpacing: 2.0)),
            ),
          ),
          SizedBox(height: 30.0),

          // contact info
          Container(
            alignment: Alignment.center,
            child: Text(
              "CONTACT INFO",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Address",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "High Court Advocate's Bar Associations Jabalpur Madhya Pradesh",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Email Us",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            child: Text(
              "hcabajassociation@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Call Us",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            child: Text(
              "+91 9907267718",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  // backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebookF),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: FaIcon(FontAwesomeIcons.googlePlusG,
                        color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  // backgroundColor: Colors.grey,
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.twitter,
                      // size: 26,
                      // color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }

  // send an email
  Future<String> sendAnEmail(String message, String email, String name) async {
    String response = "";
    response = await EmailService.sendAnEmail(email, message, name);
    return response;
  }
}
