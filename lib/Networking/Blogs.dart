import 'dart:convert';

import 'package:hcabaj/Models/blog_content_model.dart';
import 'package:http/http.dart' as http;

class Blogs {
  static Future<BlogModel?> getBlogs(String from) async {
    String url;
    // if (from == "blog")
    url = "http://hcabaj.org/API/blog-API.php";
    // else
    // url = "https://hcabaj.org/API/latest_blog.php";
    print(url);
    http.Response? response;
    // var client = http.Client();
    late BlogModel model;
    // var response;
    try {
      response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response != null && response.body != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          print("response is: ${json.decode(response.body).toString()}");
          model = BlogModel.fromJson(json.decode(response.body));
          return model;
        }
      }
    } catch (e) {
      print("exception while hitting members api: ${e.toString()}");
    }
    return BlogModel();
  }
}
