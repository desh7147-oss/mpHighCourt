import 'dart:convert';

import 'package:hcabaj/Models/galleryItemsModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const String BASE_URL_IMG = "https://hcabaj.org/API/img/";
const String BASE_URL_Blog_IMG = "https://hcabaj.org/API/blog-img/";

class GalleryItemsApi {
  static Future getTheGalleryItems() async {
    Response response;
    try {
      response = await http.get(
        Uri.parse("https://hcabaj.org/API/gallery-img-API.php"),
      );
      print("https://hcabaj.org/API/gallery-img-API.php");
      if (response != null && response.statusCode == 200) {
        print("response from galleryapi is: ${response.body}");
        GalleryItems items = GalleryItems.fromJson(jsonDecode(response.body));
        return items;
      }
    } catch (e) {
      print("oops something went wrong while fetching the gallery items");
    }
    return GalleryItems();
  }
}
