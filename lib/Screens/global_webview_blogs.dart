import 'package:flutter/material.dart';
import 'package:hcabaj/Models/blog_content_model.dart';
import 'package:hcabaj/Networking/Blogs.dart';
import 'package:hcabaj/Networking/GalleryItemsAPI.dart';
import 'package:hcabaj/Screens/BlogContentScreen.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

class GlobalWebViewBlog extends StatefulWidget {
  // const GlobalWebViewBlog({Key? key, currentScreen}) : super(key: key);

  final currentScreen;
  GlobalWebViewBlog({this.currentScreen: "blogs"});

  @override
  _GlobalWebViewBlogState createState() => _GlobalWebViewBlogState();
}

class _GlobalWebViewBlogState extends State<GlobalWebViewBlog> {
  BlogModel? items;
  var htmlContentParagraph;
  var htmlContentTitle;
  bool loaderVisibility = true;
  // init state
  void initState() {
    callTheApi();
    super.initState();
  }

  // call the api
  callTheApi() {
    Blogs.getBlogs("blog").then((value) {
      setState(() {
        items = value;
        Future.delayed(Duration(seconds: 5));
        loaderVisibility = false;
      });
    }).timeout(Duration(seconds: 10), onTimeout: () {
      setState(() {
        loaderVisibility = false;
      });
    });
    // items =
    //     await Blogs.getBlogs().timeout(Duration(seconds: 10), onTimeout: () {});
  }

  @override
  Widget build(BuildContext context) {
    bool baseCondition =
        items != null && items!.user != null && items!.user!.isNotEmpty;
    return Scaffold(
      appBar: buildGlobalAppBarWidget(context),
      body: loaderVisibility
          ? Center(
              child: CircularProgressIndicator(),
            )
          : items != null && items!.user != null
              ? RefreshIndicator(
                  onRefresh: () {
                    return Future.delayed(Duration(seconds: 1), () async {
                      await callTheApi();
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items != null && items!.user != null
                          ? items!.user!.length
                          : 0,
                      itemBuilder: (context, index) {
                        String currentImageUrl = "";
                        if (items!.user![index].blogImageUrl != null) {
                          currentImageUrl = BASE_URL_Blog_IMG +
                              items!.user![index].blogImageUrl.toString();
                        }
                        return items!.user![index].postTitle != null &&
                                items!.user![index].postContent != null &&
                                items!.user![index].blogImageUrl != null
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => BlogContentScreen(
                                              items!.user![index],
                                              currentImageUrl)));
                                },
                                child: Card(
                                  elevation: 7.0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  margin: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "${items!.user![index].postTitle}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(currentImageUrl),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(13.0),
                                        child: Text(
                                          "${items!.user![index].postContent}",
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(height: 0, width: 0);
                      },
                    ),
                  ),
                )
              : Center(child: Text("No data found")),
      drawer: buildCustomDrawer(context, widget.currentScreen),
    );
  }
}
