import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hcabaj/Utils/Colors.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';
import 'package:hcabaj/Utils/sharedPrefHelper.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  // variables
  var currentScreen;
  ProfileScreen({this.currentScreen = ""}); // constructor
  @override
  _ProfileScreenState createState() =>
      _ProfileScreenState(currentScreen: currentScreen);
}

class _ProfileScreenState extends State<ProfileScreen> {
  // constructor
  _ProfileScreenState({this.currentScreen = ""});
  // variables
  var currentScreen = "Edit Profile";
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  // late Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();
  FocusNode textFocusController = FocusNode();
  String? firstName,
      lastName,
      role,
      enrollmentNumber,
      mobileNumber,
      landlineNumber,
      email,
      officeAddress,
      homeAddress;
  int? isLoggedIn = 0;

  var msg;
  @override
  void initState() {
    initialSetup();
    super.initState();

    // razorpay = new Razorpay();
    // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void initialSetup() {
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    isLoggedIn = SharedPrefHelper.shared.getInt("isLoggedIn");
    print("role: ${SharedPrefHelper.shared.getString("role")}");
    role = SharedPrefHelper.shared.getString("role");
    email = SharedPrefHelper.shared.getString("email");
    mobileNumber = SharedPrefHelper.shared.getString("number");
    enrollmentNumber = SharedPrefHelper.shared.getString("id");
    String fullName = SharedPrefHelper.shared.getString("name").toString();
    if (fullName != null && fullName.isNotEmpty) {
      List<String> splittedName = fullName.split(" ");
      firstName = splittedName[0];
      lastName = "";
      for (int i = 1; i < splittedName.length; i++) {
        print("name" + splittedName[i]);
        String currentName =
            lastName!.isNotEmpty ? " " + splittedName[i] : splittedName[i];

        lastName = lastName! + currentName;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: buildGlobalAppBarWidget(context,
            screenSource: "from profileScreen"),
        body: _createBody(context),
        drawer: buildCustomDrawer(context, currentScreen),
        bottomNavigationBar:
            customBottomNavigationBar(context, screenSource: "My Profile"),
      ),
    );
  }

  Widget _createBody(context) {
    return SingleChildScrollView(
      child: Container(
        child: Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 28.0,
                        ),
                        child: Text(
                            SharedPrefHelper.shared.getString("name") != null
                                ? SharedPrefHelper.shared
                                    .getString("name")!
                                    .toUpperCase()
                                : "",
                            style: TextStyle(
                                color: Color(backGroundColor),
                                fontSize: 18,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20.0,
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Image.asset(
                    "lib/assets/gavel-auction-hammer-3577258.jpeg",
                    width: MediaQuery.of(context).size.width,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(-100, -30, 0),
                  child: CircleAvatar(
                      backgroundColor: Color(backGroundColor),
                      radius: 30,
                      child: Image.asset(
                          "lib/assets/HCABAJ-removebg-preview (1).png")),
                ),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Container(
                    height: 60.0,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      enabled: isLoggedIn == 0 ? true : false,
                      initialValue: firstName ?? "None",
                      style: TextStyle(color: Colors.black),
                      // obscureText: true,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        contentPadding:
                            const EdgeInsets.only(top: 18.0, bottom: 8.0),
                        labelText: "First Name",
                        labelStyle: TextStyle(color: Colors.black),
                        // helperText: "Enter your Password here",
                        // helperStyle:
                        // TextStyle(color: Colors.white60, fontSize: 12.0),
                        // enabledBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Colors.grey,
                        //     width: 1.0,
                        //     style: BorderStyle.solid,
                        //   ),
                        // ),
                      ),
                      validator: (String? name) {
                        if (name == null || name == " " || name.isEmpty) {
                          return ("name can not be empty");
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Container(
                    height: 60.0,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      initialValue: lastName ?? "None",
                      enabled: isLoggedIn == 0 ? true : false,
                      style: TextStyle(color: Colors.black),
                      // obscureText: true,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        contentPadding:
                            const EdgeInsets.only(top: 18.0, bottom: 8.0),
                        labelText: "Last Name",
                        labelStyle: TextStyle(color: Colors.black),
                        // helperText: "Enter your Password here",
                        // helperStyle:
                        // TextStyle(color: Colors.white60, fontSize: 12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (String? name) {
                        if (name == null || name == " " || name.isEmpty) {
                          return ("name can not be empty");
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Container(
                    height: 60.0,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      initialValue: role ?? "None",
                      enabled: isLoggedIn == 0 ? true : false,
                      style: TextStyle(color: Colors.black),
                      // obscureText: true,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        contentPadding:
                            const EdgeInsets.only(top: 18.0, bottom: 8.0),
                        labelText: "Role in Association",
                        labelStyle: TextStyle(color: Colors.black),
                        // helperText: "Enter your Password here",
                        // helperStyle:
                        // TextStyle(color: Colors.white60, fontSize: 12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (String? name) {
                        if (name == null || name == " " || name.isEmpty) {
                          return ("name can not be empty");
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Container(
                    height: 60.0,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      initialValue: enrollmentNumber ?? "None",
                      enabled: isLoggedIn == 0 ? true : false,
                      style: TextStyle(color: Colors.black),
                      // obscureText: true,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        contentPadding:
                            const EdgeInsets.only(top: 18.0, bottom: 8.0),
                        labelText: "Enrollment Number",
                        labelStyle: TextStyle(color: Colors.black),
                        // helperText: "Enter your Password here",
                        // helperStyle:
                        // TextStyle(color: Colors.white60, fontSize: 12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (String? name) {
                        if (name == null || name == " " || name.isEmpty) {
                          return ("name can not be empty");
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Container(
                    height: 60.0,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      initialValue: mobileNumber ?? "None",
                      enabled: isLoggedIn == 0 ? true : false,
                      style: TextStyle(color: Colors.black),
                      // obscureText: true,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        contentPadding:
                            const EdgeInsets.only(top: 18.0, bottom: 8.0),
                        labelText: "Mobile Number",
                        labelStyle: TextStyle(color: Colors.black),
                        // helperText: "Enter your Password here",
                        // helperStyle:
                        // TextStyle(color: Colors.white60, fontSize: 12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (String? name) {
                        if (name == null || name == " " || name.isEmpty) {
                          return ("name can not be empty");
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.grey)),
                    child: Container(
                      height: 60.0,
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        initialValue: landlineNumber ?? "None",
                        enabled: isLoggedIn == 0 ? true : false,
                        style: TextStyle(color: Colors.black),
                        // obscureText: true,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          contentPadding:
                              const EdgeInsets.only(top: 18.0, bottom: 8.0),
                          labelText: "Landline Number",
                          labelStyle: TextStyle(color: Colors.black),
                          // helperText: "Enter your Password here",
                          // helperStyle:
                          // TextStyle(color: Colors.white60, fontSize: 12.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        validator: (String? name) {
                          if (name == null || name == " " || name.isEmpty) {
                            return ("name can not be empty");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey)),
                  child: Container(
                    height: 60.0,
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      initialValue: email ?? "None",
                      enabled: isLoggedIn == 0 ? true : false,
                      style: TextStyle(color: Colors.black),
                      // obscureText: true,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        contentPadding:
                            const EdgeInsets.only(top: 18.0, bottom: 8.0),
                        labelText: "Email Address",
                        labelStyle: TextStyle(color: Colors.black),
                        // helperText: "Enter your Password here",
                        // helperStyle:
                        // TextStyle(color: Colors.white60, fontSize: 12.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      validator: (String? name) {
                        if (name == null || name == " " || name.isEmpty) {
                          return ("name can not be empty");
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.grey)),
                    child: Container(
                      height: 60.0,
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        initialValue: officeAddress ?? "None",
                        enabled: isLoggedIn == 0 ? true : false,
                        style: TextStyle(color: Colors.black),
                        // obscureText: true,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          contentPadding:
                              const EdgeInsets.only(top: 18.0, bottom: 8.0),
                          labelText: "Office Address",
                          labelStyle: TextStyle(color: Colors.black),
                          // helperText: "Enter your Password here",
                          // helperStyle:
                          // TextStyle(color: Colors.white60, fontSize: 12.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        validator: (String? name) {
                          if (name == null || name == " " || name.isEmpty) {
                            return ("address can not be empty");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Card(
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.grey)),
                    child: Container(
                      height: 60.0,
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 0.0, top: 0.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        initialValue: homeAddress ?? "None",
                        enabled: isLoggedIn == 0 ? true : false,
                        style: TextStyle(color: Colors.black),
                        // obscureText: true,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.red),
                          contentPadding:
                              const EdgeInsets.only(top: 18.0, bottom: 8.0),
                          labelText: "Home Address",
                          labelStyle: TextStyle(color: Colors.black),
                          // helperText: "Enter your Password here",
                          // helperStyle:
                          // TextStyle(color: Colors.white60, fontSize: 12.0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        validator: (String? name) {
                          if (name == null || name == " " || name.isEmpty) {
                            return ("Home address can not be empty");
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                    alignment: Alignment.center,
                    // width: 350.0,
                    padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        fixedSize: MaterialStateProperty.all(
                          Size.fromHeight(40),
                        ),
                        shape: MaterialStateProperty.all(
                          StadiumBorder(
                              // borderRadius: BorderRadius.circular(10.0),
                              ),
                        ),
                      ),
                      onPressed: () {
                        openCheckout;
                      },
                      child: Text("Edit Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              letterSpacing: 2.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Visibility(
                  visible: isLoggedIn == 1 ? true : false,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 25.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.redAccent),
                        fixedSize: MaterialStateProperty.all(
                          Size.fromHeight(50),
                        ),
                        shape: MaterialStateProperty.all(
                          StadiumBorder(
                              // borderRadius: BorderRadius.circular(10.0),
                              ),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => PaymentGateWayScreen(),
                        //   ),
                        // );
                        // launch url for url launcher
                        String url =
                            "https://hcabaj.org/API/newrazarpay/payment-page.php?amount=1000&plan_id=2&user_id=${SharedPrefHelper.shared.getString("id") ?? 0}";
                        launchURL(url);
                      },
                      child: Text("PAY YOUR SUBSCRIPTION",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              letterSpacing: 2.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // RAZORPAY HANDLERS
  void openCheckout() {
    var options = {
      "key": "rzp_live_ILgsfZCZoFIKMb",
      "amount": num.parse(textEditingController.text) *
          100, // Convert Paisa to Rupees
      "name": "Test Payment By Desh",
      "description": "This is a Test Payment",
      "timeout": "180",
      "theme.color": "#03be03",
      "currency": "INR",
      "prefill": {'contact': '8888888888', 'email': 'test@razorpay.com'},
      "external": {
        "wallets": ["paytm"]
      }
    };

    // try {
    //   razorpay.open(options);
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  // void handlerPaymentSuccess(PaymentSuccessResponse response) {
  //   print("Pament success");
  //   msg = "SUCCESS: " + response.paymentId!;
  //   showToast(msg);
  // }

  // void handlerErrorFailure(PaymentFailureResponse response) {
  //   msg = "ERROR: " +
  //       response.code.toString() +
  //       " - " +
  //       jsonDecode(response.message!)['error']['description'];
  //   showToast(msg);
  // }

  // void handlerExternalWallet(ExternalWalletResponse response) {
  //   msg = "EXTERNAL_WALLET: " + response.walletName!;
  //   showToast(msg);
  // }

  showToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.withOpacity(0.1),
      textColor: Colors.black54,
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
