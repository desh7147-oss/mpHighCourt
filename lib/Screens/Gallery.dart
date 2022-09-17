import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hcabaj/Models/galleryItemsModel.dart';
import 'package:hcabaj/Networking/GalleryItemsAPI.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/bottomNavigation.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ImageViwerScreen.dart';

class GalleryScreen extends StatefulWidget {
  // variables
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final currentScreen = "Gallery";
  List<User>? users = [];
  bool loaderVisibility = true;

  late WebViewController controller;

  @override
  void initState() {
    makeTheApiCalls();
    super.initState();
  }

  makeTheApiCalls({int index: 0}) {
    late GalleryItems items;
    GalleryItemsApi.getTheGalleryItems().then((value) {
      setState(() {
        items = value;
        loaderVisibility = false;
      });
      String postContent = "";
      if (items != null &&
          items.status == 1 &&
          items.user != null &&
          items.user!.isNotEmpty &&
          items.user![index] != null) {
        setState(() {
          users = items.user;
          postContent = users![index].postContent.toString();
          Future.delayed(Duration(seconds: 5));
          loaderVisibility = false;
        });
      }
    }).timeout(Duration(seconds: 10), onTimeout: () {
      setState(() {
        loaderVisibility = false;
        items = GalleryItems();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () async {
          await makeTheApiCalls();
        });
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          appBar: buildGlobalAppBarWidget(context),
          body: _createBody(context),
          drawer: buildCustomDrawer(context, "Gallery"),
          bottomNavigationBar: customBottomNavigationBar(context),
        ),
      ),
    );
  }

  Widget _createBody(context) {
    List<String> galleryItems = [
      "lib/assets/Gallery/board1.jpeg",
      "lib/assets/Gallery/boardImage.jpeg",
      "lib/assets/Gallery/FrontCourt.jpeg",
      "lib/assets/Gallery/typeWriter.jpeg",
      "lib/assets/Gallery/workingGuy.jpeg",
      "lib/assets/law-books-library-rows-of-books-291676.jpeg",
      "lib/assets/background.jpeg",
      "lib/assets/Gallery/NatureBg.jpeg",
    ];

    return loaderVisibility
        ? Center(
            child: CircularProgressIndicator(),
          )
        : users == null
            ? Center(
                child: Container(
                child: Text("No Items found"),
              ))
            : Container(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                          child: Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                letterSpacing: 2.0),
                          )),
                      Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            "OUR MEMORIES",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 19),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            // ListView.builder(
                            //   itemCount:
                            //       users != null && users!.isNotEmpty ? users!.length : 0,
                            //   shrinkWrap: true,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   itemBuilder: (context, index) {
                            //     return Container(
                            //         child: Html(
                            //       data: users![index].postContent,
                            //     ));
                            //   },

                            GridView.builder(
                                itemCount: users!.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20),
                                itemBuilder: (ctx, index) {
                                  String currentImageUrl = "";
                                  if (users![index].imageUrl != null) {
                                    currentImageUrl = BASE_URL_IMG +
                                        users![index].imageUrl.toString();
                                  }
                                  print(
                                      "current url: ${users![index].imageUrl != null ? BASE_URL_IMG + users![index].imageUrl.toString() : ""}");
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ImageViewerScreen(
                                              index,
                                              users![index].imageUrl.toString(),
                                              users);
                                        }));
                                      },
                                      child: users![index].imageUrl != null
                                          ? Image.network("${currentImageUrl}",
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100)
                                          : Container());
                                }),
                      ),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  ),
                ),
              );

    // loadingBuilder: (context, event) => Center(
    //   child: Container(
    //     width: 20.0,
    //     height: 20.0,
    //     child: CircularProgressIndicator(
    //       value: event == null
    //           ? 0
    //           : event.cumulativeBytesLoaded / event.expectedTotalBytes,
    //     ),
    //   ),
    // ),
    // backgroundDecoration: backgroundDecor /
    // pageController: widget.pageController,
    // onPageChanged: onPageChanged,
  }
}
