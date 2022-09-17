import 'package:flutter/material.dart';
import 'package:hcabaj/Screens/HomeScreen.dart';
import 'package:hcabaj/Screens/PaymentGatewayScren.dart';
import 'package:hcabaj/Utils/Colors.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

class PaySubscriptionScreen extends StatefulWidget {
  const PaySubscriptionScreen({Key? key}) : super(key: key);
  static const List<String> _radioItems = [
    "Rs 2500/-(For Members having upto 5 years of practice)",
    "Rs 4000/-(For Members having more than 5 years of practice",
    "Rs 5000/-(For Senior Advocates)"
  ];

  @override
  _PaySubscriptionScreenState createState() => _PaySubscriptionScreenState();
}

class _PaySubscriptionScreenState extends State<PaySubscriptionScreen> {
  String radioValue = PaySubscriptionScreen._radioItems[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createBody(context),
      appBar: buildGlobalAppBarWidget(context, isFromPaymentScreen: true),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Widget _createBody(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 25.0, left: 10.0, bottom: 0, right: 10.0),
      child: Card(
        margin: const EdgeInsets.only(top: 70.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// heading Pay your subscription
            Container(
              margin: const EdgeInsets.fromLTRB(12.0, 30.0, 12.0, 12.0),
              child: Text(
                "Pay your subscription fee here",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.redAccent,
                  fontSize: 30.0,
                  letterSpacing: 0.7,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              leading: Radio(
                groupValue: radioValue,
                value: PaySubscriptionScreen._radioItems[0],
                onChanged: (String? newValue) {
                  setState(() {
                    radioValue = newValue!;
                  });
                },
              ),
              title: Text("${PaySubscriptionScreen._radioItems[0]}"),
            ),

            SizedBox(
              height: 20.0,
            ),

            /// list tile for 4000
            ListTile(
              leading: Radio(
                groupValue: radioValue,
                value: PaySubscriptionScreen._radioItems[1],
                onChanged: (String? newValue) {
                  setState(() {
                    radioValue = newValue!;
                  });
                },
              ),
              title: Text("${PaySubscriptionScreen._radioItems[1]}"),
            ),

            SizedBox(
              height: 20.0,
            ),

            /// list tile for 5000
            ListTile(
              leading: Radio(
                groupValue: radioValue,
                value: PaySubscriptionScreen._radioItems[2],
                onChanged: (String? newValue) {
                  setState(() {
                    radioValue = newValue!;
                  });
                },
              ),
              title: Text("${PaySubscriptionScreen._radioItems[2]}"),
            ),

            SizedBox(
              height: 15.0,
            ),

            /// Button pay your subscription
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                fixedSize: MaterialStateProperty.all(
                  Size.fromHeight(40),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentGateWayScreen()),
                );
              },
              child: Text("PAY YOUR SUBSCRIPTION",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      letterSpacing: 2.0)),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  /// bottom navigation bar
  Widget buildBottomNavigationBar(BuildContext context) {
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
          items: [
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
                  Navigator.pop(context);
                },
              ),
              label: "",
            ),
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
          ],
        ),
      ),
    );
  }
}
