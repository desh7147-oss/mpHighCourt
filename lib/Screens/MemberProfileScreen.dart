import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hcabaj/Utils/BasePaths.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';
import 'package:hcabaj/Utils/sharedPrefHelper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/MemberDetailsModel.dart';

class MemberProfileDetailsScreen extends StatelessWidget {
  final User memberDetails;
  final String firstName;
  final String lastName;
  MemberProfileDetailsScreen(
    this.memberDetails,
    this.firstName,
    this.lastName, {
    Key? key,
  }) : super(key: key);

  final headingTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    fontFamily: "Roboto",
    letterSpacing: 0.5,
  );

  final subHeadingTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: "Roboto",
    letterSpacing: 0.35,
    fontSize: 20.0,
  );

  final inputTextstyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontFamily: "Roboto",
    fontSize: 18.0,
  );

  final Widget divider = Container(
    width: double.infinity - 20.0,
    child: Divider(
      thickness: 1.9,
      color: Colors.white60.withOpacity(1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildGlobalAppBarWidget(context),
      bottomNavigationBar: customBottomNavigationBar(context),
      body: createBody(context),
    );
  }

  Widget createBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin:
                  const EdgeInsets.only(left: 10.0, bottom: 15.0, top: 20.0),

              /// member name heading
              child: Text(
                memberDetails.displayName != null
                    ? memberDetails.displayName.toString()
                    : "***",
                textAlign: TextAlign.center,
                style: headingTextStyle,
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "lib/assets/gavel-auction-hammer-3577258.jpeg",
                      colorBlendMode: BlendMode.colorBurn,
                      fit: BoxFit.fill,
                      height: 155.0,
                      width: MediaQuery.of(context).size.width - 40,
                    ),
                  ),
                  Transform(
                    transform: Matrix4.translationValues(0, -40, 0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                          baseImagePath + memberDetails.profileImg!.toString()),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: CachedNetworkImage(
                          imageUrl: baseImagePath +
                              memberDetails.profileImg!.toString(),
                          placeholder: (ctx, url) => Image.asset(
                            "lib/assets/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpeg",
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (ctx, url, error) => Image.asset(
                              "lib/assets/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpeg"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// hammer image + circular avatar
            ),
            divider,
            SizedBox(
              height: 25.0,
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Text(
                "First Name",
                style: subHeadingTextStyle,
              ),
            ),
            divider,
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                firstName,
                style: inputTextstyle,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Text(
                "Last Name",
                style: subHeadingTextStyle,
              ),
            ),
            divider,
            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Text(
                lastName,
                style: inputTextstyle,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Text(
                "Email Address",
                style: subHeadingTextStyle,
              ),
            ),
            divider,
            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Text(
                memberDetails.userEmail != null
                    ? memberDetails.userEmail.toString()
                    : "***",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Text(
                "Contact Number",
                style: subHeadingTextStyle,
              ),
            ),
            divider,
            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Text(
                memberDetails.userNumber != null
                    ? memberDetails.userNumber.toString()
                    : "***",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Roboto",
                  fontSize: 18.0,
                ),
              ),
            ),

            /// Button pay your subscription
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: SharedPrefHelper.shared.getString("name") != null &&
                      SharedPrefHelper.shared
                              .getString("name")!
                              .toLowerCase() ==
                          memberDetails.displayName!.toLowerCase(),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      fixedSize: MaterialStateProperty.all(
                        Size.fromHeight(40),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    onPressed: () {
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
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
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
