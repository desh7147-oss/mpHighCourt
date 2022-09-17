import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hcabaj/Models/blog_content_model.dart';
import 'package:hcabaj/Networking/GalleryItemsAPI.dart';
import 'package:hcabaj/Screens/AboutUs.dart';
import 'package:hcabaj/Screens/BlogContentScreen.dart';
import 'package:hcabaj/Screens/History.dart';
import 'package:hcabaj/Screens/global_webview_blogs.dart';
import 'package:hcabaj/Utils/Colors.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Networking/Blogs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variables
  var currentScreen = "Home";
  late ScrollController _scrollController;
  int activePage = 1;
  int activeExecutive = 1;
  int activeBlog = 1;
  BlogModel? items;
  bool loaderVisibility = false;
  int currentIndex = 0;

  // List variables

  final executiveBodyMembers = [
    "lib/assets/ExecutivebodyMembers/President.png",
    "lib/assets/ExecutivebodyMembers/VicePresident.png",
    "lib/assets/ExecutivebodyMembers/Secretary.png",
    "lib/assets/ExecutivebodyMembers/JointSecretary.png",
    "lib/assets/ExecutivebodyMembers/Treasurer.png",
    "lib/assets/ExecutivebodyMembers/LibrarySecretary.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember1.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember2.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember3.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember4.png",
    "lib/assets/ExecutivebodyMembers/ExecutiveMember5.png"
  ];

  final bottomBarButtonsList = [
    "About",
    "Contact",
    "Privacy Policy",
    "Terms & Services"
  ];

  @override // NEW
  void initState() {
    // NEW
    makeTheApiCalls();
    super.initState(); // NEW
    // _scrollController = new ScrollController(
    //   // NEW
    //   initialScrollOffset: 0.0, // NEW
    //   keepScrollOffset: true, // NEW
    // );
  }

  void makeTheApiCalls() async {
    items = await Blogs.getBlogs("home").timeout(Duration(seconds: 10),
        onTimeout: () {
      setState(() {
        loaderVisibility = false;
      });
    });
    setState(() {
      items = items;
      Future.delayed(Duration(seconds: 5));
      loaderVisibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final intro_images = [
      buildIntroductionImageOne(context),
      // buildIntroductionImageTwo(context),
      // buildIntroductionImageThree(context)
    ];
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: buildGlobalAppBarWidget(context),
          body: _createBodyWidget(context, intro_images),
          drawer: buildCustomDrawer(context, "Home"),
          bottomNavigationBar:
              customBottomNavigationBar(context, screenSource: "Home"),
        ),
      ),
    );
  }

  Widget _createBodyWidget(BuildContext context, List<Widget> intro_images) {
    return ListView(
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      children: <Widget>[
        // Image.asset(""),
        Container(
          height: MediaQuery.of(context).size.height / 3,
          padding: const EdgeInsets.all(0.0),
          // Introduction elements(images + text )
          child: buildIntroductionImageOne(context),
        ),
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: indicators(intro_images.length, activePage)),
        SizedBox(height: 20.0),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Executive Body",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
        // advocatory body Introduction( images + text )
        _createAdvocatoryBodyIntroduction(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(executiveBodyMembers.length, activeExecutive),
        ),
        SizedBox(
          height: 20.0,
        ),
        // Important links
        Container(
          alignment: Alignment.center,
          // margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Important Links",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),

        // widget important links
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 150.0,
              width: MediaQuery.of(context).size.width,
              child: buildImportantLinksWidget(context)),
        ),

        //  upcoming events
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              top: 0.0, bottom: 20.0, left: 10.0, right: 10.0),
          child: Text(
            "Upcoming Events",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25.0,
              color: Colors.black,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 70.0,
            // color: Colors.red,
            height: 3.0,
            child: Divider(
              color: Colors.red,
              thickness: 4.0,
            ),
          ),
        ),
        // widget upcoming events
        buildUpcomingEventsWidget(context),
        SizedBox(height: 30.0),
        // section explore the law
        // buildExploreTheLawSection(context),
        // SizedBox(height: 50.0),
        // upcoming seminars widget
        // buildUpcomingSeminarsWidget(context),
        // SizedBox(height: 20.0),
        // buildBottomBarWidget(context),
      ],
    );
  }

  Widget buildIntroductionImageOne(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          // child: Image.asset('lib/assets/background.jpeg',
          //     height: MediaQuery.of(context).size.height / 2,
          //     width: MediaQuery.of(context).size.width,
          //     scale: 1.0,
          //     fit: BoxFit.cover),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "lib/assets/background.jpeg",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.srcOver)),
          ),
        ),
        Container(
          alignment: Alignment.center,
          transform: Matrix4.translationValues(0, -15, 0),
          // margin: const EdgeInsets.only(left: 75.0),
          height: 120.0,
          width: MediaQuery.of(context).size.width - 150,
          child: Image.asset('lib/assets/HCABAJ-removebg-preview.png',
              fit: BoxFit.fill),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(
              top: 180.0, left: 5.0, right: 5.0, bottom: 30.0),
          child: Text(
            "High Court Advocates' Bar Association Jabalpur",
            overflow: TextOverflow.visible,
            textScaleFactor: 1.0,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              // // fontWeight: FontWeight.w500,
              fontSize: 19.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildIntroductionImageTwo(BuildContext context) {
    return Container(
      // transform: Matrix4.translationValues(-70.17, 0, 0),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Image.asset("lib/assets/introImage2.jpg", fit: BoxFit.fitWidth),
    );
  }

  Widget buildIntroductionImageThree(BuildContext context) {
    return Container(
      // transform: Matrix4.translationValues(-70.17, 0, 0),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Image.asset(
        "lib/assets/Gallery/hcabaj1.png",
        // height: 300.0,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
        // color: Colors.white,
      ),
    );
  }

  Widget _createAdvocatoryBodyIntroduction(BuildContext context) {
    return Container(
      color: Colors.white30,
      transform: Matrix4.translationValues(0, -8.0, 0),
      height: MediaQuery.of(context).size.height / 3 - 80,
      padding: const EdgeInsets.all(10.0),
      // Introduction elements(images + text )
      child: CarouselSlider.builder(
        options: CarouselOptions(
            autoPlay: true,
            height: double.infinity,
            viewportFraction: 0.37,
            enlargeCenterPage: true,
            // padEnds: false,
            onPageChanged: (currentPage, _) {
              setState(() {
                activeExecutive = currentPage;
              });
            }),
        itemCount:
            executiveBodyMembers != null && executiveBodyMembers.isNotEmpty
                ? executiveBodyMembers.length
                : 0,
        itemBuilder: (BuildContext context, int index, _) {
          return Container(
            child: Image.asset(executiveBodyMembers[index]),
          );
        },
      ),
    );
  }

// carousel indicators
  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  // important links
  Widget buildImportantLinksWidget(BuildContext context) {
    final importantLinks = [
      "Supreme Court of India",
      "Madhya Pradesh High Court",
      "District Court of Jabalpur",
      "Central Admin Tribunal",
      "Armed Forces Tribunal",
      "E-Courts Services of India",
    ];

    final importantLinksUrl = [
      "https://main.sci.gov.in/",
      "https://mphc.gov.in/causelist",
      "https://districts.ecourts.gov.in/jabalpur",
      "http://www.cgatnew.gov.in/catweb/Delhi/Delhi.php",
      "https://aftjabalpur.in/",
      "https://ecourts.gov.in/ecourts_home/",
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        mainAxisExtent: 40,
      ),
      itemCount: importantLinks != null && importantLinks.isNotEmpty
          ? importantLinks.length
          : 0,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(0.0),
          child: InkWell(
            onTap: () async {
              var url = importantLinksUrl[index];
              launchURL(url);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FittedBox(
                  // height: 30.0,
                  // margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: IconButton(
                    icon: Image.asset(
                      "lib/assets/global.png",
                      color: Colors.white,
                      height: 20,
                    ),
                    color: Colors.white,
                    onPressed: () async {
                      //   var url = importantLinksUrl[index];
                      //   if (await canLaunch(url)) {
                      //     await launch(url);
                      //   } else {
                      //     throw 'Could not launch $url';
                    },
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(-4, 0, 0),
                  child: FittedBox(
                    // fit: BoxFit.fitWidth,
                    child: Text(
                      importantLinks[index],
                      // overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.0,
                        // fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    // );
    // return Row(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Container(
    //       width: MediaQuery.of(context).size.width / 2 - 20,
    //       child: ListView.builder(
    //           shrinkWrap: true,
    //           padding: const EdgeInsets.all(0.0),
    //           // physics: ScrollPhysics(),
    //           itemCount: 3,
    //           // gridDelegate:
    //           //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //           itemBuilder: (context, index) {
    //             return Container(
    //               margin: const EdgeInsets.only(
    //                   left: 10.0, bottom: 10.0, right: 10.0),
    //               decoration: BoxDecoration(
    //                 color: Colors.red,
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               width: MediaQuery.of(context).size.width,
    //               padding: const EdgeInsets.all(0.0),
    //               child: InkWell(
    //                 onTap: () async {
    //                   var url = importantLinksUrl[index];
    //                   launchURL(url);
    //                 },
    //                 child: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     FittedBox(
    //                       // height: 30.0,
    //                       // margin: const EdgeInsets.only(left: 8.0, right: 8.0),
    //                       child: IconButton(
    //                         icon: Image.asset(
    //                           "lib/assets/global.png",
    //                           color: Colors.white,
    //                           height: 20,
    //                         ),
    //                         color: Colors.white,
    //                         onPressed: () async {
    //                           //   var url = importantLinksUrl[index];
    //                           //   if (await canLaunch(url)) {
    //                           //     await launch(url);
    //                           //   } else {
    //                           //     throw 'Could not launch $url';
    //                         },
    //                       ),
    //                     ),
    //                     FittedBox(
    //                       child: Text(
    //                         importantLinks[index],
    //                         // overflow: TextOverflow.clip,
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                           // fontSize: 17.0,
    //                           // fontWeight: FontWeight.normal,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           }),
    //     ),
    //     Container(
    //       width: MediaQuery.of(context).size.width / 2 - 20,
    //       child: ListView.builder(
    //           shrinkWrap: true,
    //           padding: const EdgeInsets.all(0.0),
    //           // physics: ScrollPhysics(),
    //           itemCount:
    //               importantLinks2.isNotEmpty ? importantLinks2.length : 0,
    //           // gridDelegate:
    //           //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //           itemBuilder: (context, index) {
    //             return Container(
    //               margin: const EdgeInsets.only(
    //                   left: 10.0, bottom: 10.0, right: 10.0),
    //               decoration: BoxDecoration(
    //                 color: Colors.red,
    //                 borderRadius: BorderRadius.circular(8.0),
    //               ),
    //               width: MediaQuery.of(context).size.width,
    //               padding: const EdgeInsets.all(0.0),
    //               child: InkWell(
    //                 onTap: () async {
    //                   var url = importantLinksUrl2[index];
    //                   launchURL(url);
    //                 },
    //                 child: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                       height: 30.0,
    //                       // margin: const EdgeInsets.only(left: 8.0, right: 8.0),
    //                       child: IconButton(
    //                         icon: Image.asset(
    //                           "lib/assets/global.png",
    //                           color: Colors.white,
    //                           height: 20,
    //                         ),
    //                         color: Colors.white,
    //                         onPressed: () async {
    //                           //   var url = importantLinksUrl[index];
    //                           //   if (await canLaunch(url)) {
    //                           //     await launch(url);
    //                           //   } else {
    //                           //     throw 'Could not launch $url';
    //                         },
    //                       ),
    //                     ),
    //                     FittedBox(
    //                       child: Text(
    //                         importantLinks2[index],
    //                         // overflow: TextOverflow.clip,
    //                         style: TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 17.0,
    //                           fontWeight: FontWeight.normal,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           }),
    //     ),
    //   ],
    // );
  }

// widget upcoming events
  Widget buildUpcomingEventsWidget(BuildContext context) {
    return items != null && items!.user != null
        ? Container(
            child: Column(
              // fit: StackFit.passthrough,
              // alignment: Alignment.center,
              children: [
                //  upcoming events
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white30,
                  ),
                  height: 350,
                  padding: const EdgeInsets.all(10.0),
                  // Introduction elements(images + text )
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                        autoPlay: true,
                        height: double.infinity,
                        padEnds: false,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        // padEnds: false,
                        onPageChanged: (currentPage, _) {
                          setState(() {
                            activeBlog = currentPage;
                          });
                        }),
                    itemCount: items != null &&
                            items!.user != null &&
                            items!.user!.isNotEmpty
                        ? items!.user!.length
                        : 0,
                    itemBuilder: (BuildContext context, int index, _) {
                      currentIndex = index;
                      print(
                          "blog image url from home: ${BASE_URL_Blog_IMG + items!.user![index].blogImageUrl.toString()}");
                      String currentImageUrl = BASE_URL_Blog_IMG +
                          items!.user![index].blogImageUrl.toString();
                      return Column(children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => BlogContentScreen(
                                        items!.user![index], currentImageUrl)));
                          },
                          child: Container(
                            height: 270.0,
                            margin: const EdgeInsets.only(top: 10.0),
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  currentImageUrl,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            // child: Image.network(
                            //   BASE_URL_Blog_IMG +
                            //       items!.user![index].blogImageUrl.toString(),
                            //   height: 270.0,
                            //   width: MediaQuery.of(context).size.width - 20,
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 11.0),
                            child: Text(
                              items!.user![index].postTitle.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            )),
                      ]);
                    },
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                //   child: Image.network("lib/assets/libra-scales-justice-2754246.png",
                //       fit: BoxFit.fitHeight,
                //       height: 200.0,
                //       width: MediaQuery.of(context).size.width - 50),
                // ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Text(
                    items!.user![currentIndex].postContent.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 135.0,
                      maxHeight: 40.0,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(StadiumBorder()),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GlobalWebViewBlog(
                              currentScreen: "latest news",
                            );
                          }));
                        },
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.only(left: 10.0, right: 5.0),
                              child: Text(
                                "KNOW MORE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  // explore the law section
  Widget buildExploreTheLawSection(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 430.0,
      ),
      child: Container(
        height: double.infinity,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "lib/assets/law-books-library-rows-of-books-291676.jpeg",
                    ),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.srcOver)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height / 5,
              child: Image.asset("lib/assets/HCABAJ-removebg-preview.png",
                  // filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,
                  height: 200.0),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60.0),
              alignment: Alignment.center,
              child: Text(
                "EXPLORE THE LAW",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 110.0),
              transform: Matrix4.translationValues(-90, 0, 0),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 3.0,
                  width: 70.0,
                  child: Divider(
                    color: Colors.red,
                    thickness: 3.0,
                  ),
                ),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 12.0, top: 210.0, right: 10.0),
              alignment: Alignment.center,
              child: Text(
                "This is a Association of M.P. High Court Advocates, joins us for Important updates which helps your Law Practice for more details contact us and get our subscription now",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 135.0,
                    maxHeight: 40.0,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(StadiumBorder()),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HistoryScreen();
                      }));
                    },
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 10.0, right: 5.0),
                          child: Text(
                            "KNOW MORE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // upcoming seminars widget
  Widget buildUpcomingSeminarsWidget(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 45.0, bottom: 5.0),
            child: Text(
              "UPCOMING SEMINAR & UPDATES",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 25.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 3.0,
              width: 70.0,
              child: Divider(
                thickness: 3.0,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            child: Text(
              "This is M.P. High Court Advocates\’ Bar Association Jabalpur website for members of this association. our intention is to giving updates related to law and other important notice regarding executive bodies. ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 15.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, bottom: 15.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 135.0,
                maxHeight: 40.0,
              ),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(StadiumBorder()),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AboutScreen();
                    }));
                  },
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 10.0, right: 5.0),
                        child: Text(
                          "LEARN MORE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          // Container(
          //   margin: const EdgeInsets.only(top: 20.0),
          //   child: Image.asset(
          //     "lib/assets/legal-right-justice-5211993-682x1024.jpg",
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(top: 20.0),
          //   child: Image.asset("lib/assets/the-legal-justice-law-4926021.jpg"),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(top: 20.0),
          //   child: Image.asset(
          //       "lib/assets/hammer-horizontal-court-802296-1024x768.jpg"),
          // ),
        ],
      ),
    );
  }

  // bottom bar
  Widget buildBottomBarWidget(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      color: Color(bottomBarColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            child: Text(
              "High Court Advocates' Bar Associations  Jabalpur M.P. | ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                height: 2.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: Text(
              "Phone: 9907267718 | Email: hcabajassociation@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                height: 2.0,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 15.0),
            child: Text(
              "Copyright © DoaGuru Info Systems",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: bottomBarButtonsList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 8.0),
                alignment: Alignment.center,
                child: InkWell(
                    onTap: () {
                      print("tapped");
                    },
                    child: Text(
                      bottomBarButtonsList[index],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
              );
            },
          ),
        ],
      ),
    );
  }

  // launch url for url launcher
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
