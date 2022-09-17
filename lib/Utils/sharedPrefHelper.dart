import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences shared;
  static getInstance() async {
    shared = await SharedPreferences.getInstance();
    return shared;
  }

  static clear() {
    SharedPrefHelper.shared.remove("name");
    SharedPrefHelper.shared.remove("id");
    SharedPrefHelper.shared.remove("email");
    SharedPrefHelper.shared.remove("number");
    SharedPrefHelper.shared.remove("role");
    SharedPrefHelper.shared.remove("token");
    SharedPrefHelper.shared.remove("isLoggedIn");
  }
}
