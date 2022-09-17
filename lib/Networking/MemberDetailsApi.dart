import 'dart:convert';

import 'package:hcabaj/Models/MemberDetailsModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MemberDetailsApi {
  static Future<MemberDetailsModel> getMemberDetails() async {
    String url = "https://hcabaj.org/API/API.php";
    print(url);
    Response? response;
    late MemberDetailsModel model;
    try {
      response = await http.get(Uri.parse(url));
    } catch (e) {
      print("exception while hitting members api: ${e.toString()}");
    }
    if (response != null && response.body != null) {
      print("response is: ${response.body.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        model = MemberDetailsModel.fromJson(jsonDecode(response.body));
      }
    }
    return model;
  }
}
