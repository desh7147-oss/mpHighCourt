import 'package:flutter/material.dart';
import 'package:hcabaj/Models/blog_content_model.dart';
import 'package:hcabaj/Utils/Drawer.dart';
import 'package:hcabaj/Utils/globalAppBar.dart';

class BlogContentScreen extends StatelessWidget {
  final User blog;
  final String currentImageUrl;
  const BlogContentScreen(this.blog, this.currentImageUrl, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildGlobalAppBarWidget(context),
      body: createBody(context),
      drawer: buildCustomDrawer(context, "blog content"),
    );
  }

  Widget createBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            elevation: 7.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "${blog.postTitle}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(currentImageUrl),
                ),
                Container(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    "${blog.postContent}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
