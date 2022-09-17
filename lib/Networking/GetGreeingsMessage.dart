import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hcabaj/Models/GeneratedMessageModel.dart';
import 'package:hcabaj/Models/OccasionsModel.dart';
import 'package:hcabaj/Utils/sharedPrefHelper.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MessageHandling {
  // get the message
  static Future<String?> getGreetingsMessage(
      {String? occasion = "Meeting"}) async {
    String url =
        "https://hcabaj.org/API/SMS-Occation-temp.php?occasion=${occasion}";
    debugPrint("${url}");
    try {
      Response response = await http.get(Uri.parse(url));
      if (response != null &&
          response.statusCode != null &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        debugPrint(
            "status: ${response.statusCode} and response: ${response.body}");
        GeneratedMessageModel messageModel =
            GeneratedMessageModel.fromJson(jsonDecode(response.body));
        if (messageModel != null &&
            messageModel.user != null &&
            messageModel.user!.isNotEmpty) {
          String? message = messageModel.user![0].temp;
          return message;
        } else
          return "";
      }
    } catch (e) {
      debugPrint("exception caught while getting the greeting message");
    }
  }

  // send the message
  static Future<bool> sendTheMessage(
      {String? number,
      String? value,
      String? selectedFesValue,
      String? message}) async {
    if (value!.toLowerCase() == "number" || number!.isNotEmpty) {
      value = "Other_Number";
    } else if (value.toLowerCase() == "member") {
      value = "All_Members";
    }
    String url =
        "https://hcabaj.org/API/SMS-condition-check-API.php?selected_value=${value}&selected_fes=${selectedFesValue}&number=${number}&msg=${message}";
    debugPrint("${url}");
    try {
      debugPrint("API body: ${{
        "selected_value": value,
        "selected_fes": selectedFesValue,
        "number": number,
        "msg": message,
      }}");

      Response response = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json/text",
        "Authorization": SharedPrefHelper.shared.getString("token") != null &&
                SharedPrefHelper.shared.getString("token").toString().isNotEmpty
            ? SharedPrefHelper.shared.getString("token").toString()
            : ""
      }, body: {
        "selected_value": value,
        "selected_fes": selectedFesValue,
        "number": number,
        "msg": message,
      });
      if (response != null && response.statusCode != null) {
        debugPrint(
            "status: ${response.statusCode} and response: ${response.body}");
        return true;
      }
    } catch (e) {
      debugPrint("exception caught while sending the message: ${e.toString()}");
    }
    return false;
  }

  static Future<List<String>> getOccasions() async {
    try {
      String url = "https://hcabaj.org/API/occasion_name.php";
      print(url);
      final Response result = await http.get(Uri.parse(url));
      print("calling");
      if (result.statusCode == 200 || result.statusCode == 201) {
        print("inside if");
        final output = jsonDecode(result.body);
        print("occasion body: $output");
        OccasionsModel model = OccasionsModel.fromJson(output);
        List<String> occasionNames = ["Select Occasion--"];
        if (model.user != null) {
          print("inside second if");
          for (int i = 0; i < model.user!.length; ++i) {
            if (model.user![i].occasion != null) {
              print("adding: ${model.user![i].occasion.toString()}");
              occasionNames.add(model.user![i].occasion.toString());
            }
          }
        }
        print("output: ${output}");
        return occasionNames;
      }
    } catch (e) {
      print("exception caught while getting the occasions: ${e.toString()}");
    }
    List<String> names = ["Select Occasion--"];
    return names;
  }
}
