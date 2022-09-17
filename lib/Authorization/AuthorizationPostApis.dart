import 'dart:convert';

import 'package:hcabaj/Models/LoginResponseModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/sharedPrefHelper.dart';

class AuthorizationGetApi {
  // login method
  static Future<LoginResponseModel> loginPostApi(
      Map<String, String> body) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    final String _loginUri =
        "https://hcabaj.org/API/login-tokan.php?user=${body["user"]}&password=${body["password"]}";
    print(_loginUri);
    var response = await http.post(Uri.parse(_loginUri), body: body, headers: {
      "Accept": "application/json/text",
    });

    if (response != null && response.body != null) {
      try {
        print("response from login api:::::::: ${response.body.toString()}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          LoginResponseModel loginResponse =
              await LoginResponseModel.fromJson(json.decode(response.body));
          SharedPrefHelper.shared.setInt("isLoggedIn", 1);
          SharedPrefHelper.shared
              .setString("name", loginResponse.data!.name.toString());
          SharedPrefHelper.shared
              .setString("email", loginResponse.data!.email.toString());
          SharedPrefHelper.shared
            ..setString("role", loginResponse.data!.role.toString());
          SharedPrefHelper.shared
              .setString("id", loginResponse.data!.id.toString());
          SharedPrefHelper.shared
              .setString("number", loginResponse.data!.number.toString());
          SharedPrefHelper.shared
              .setString("token", loginResponse.data!.token.toString());
          return loginResponse;
        } else
          throw Exception("oops something went wrong");
      } catch (e) {
        print("exception thrown: ${e.toString}");
      }
    }
    LoginResponseModel loginResponse = LoginResponseModel();
    return loginResponse;
  }
}
