import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hcabaj/Utils/Colors.dart';

import '../Models/galleryItemsModel.dart';
import '../Networking/GalleryItemsAPI.dart';

class ImageViewerScreen extends StatelessWidget {
  // variables
  int currentIndex = 0;
  List<User>? users = [];
  String imageUrl = "";
  ImageViewerScreen(this.currentIndex, this.imageUrl, this.users);
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

  // build
  @override
  Widget build(BuildContext context) {
    int endIndex = users!.length - 1;
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(backGroundColor),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          // color: Color(backGroundColor),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: CarouselSlider.builder(
            itemCount: endIndex + 1,
            options: CarouselOptions(
              autoPlay: true,
              height: double.infinity,
              viewportFraction: 1.0,
              // enlargeCenterPage: true,
              enableInfiniteScroll: false,
              initialPage: currentIndex,
            ),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return InteractiveViewer(
                panEnabled: false, // Set it to false
                scaleEnabled: true,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.5,
                maxScale: 2,
                child: Container(
                  child: Image.network(
                      "${BASE_URL_IMG + users![index].imageUrl.toString()}"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
