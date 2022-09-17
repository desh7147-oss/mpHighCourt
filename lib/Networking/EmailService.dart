import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class EmailService {
  static Future<String> sendAnEmail(
      String email, String message, String name) async {
    String url =
        "https://hcabaj.org/API/contact-form.php?name=${name}&email=${email}&msg=${message}";
    print(url);
    try {
      Response responseModel = await http.get(Uri.parse(url));
      if (responseModel != null &&
          responseModel.statusCode != null &&
          (responseModel.statusCode == 200 ||
              responseModel.statusCode == 201)) {
        return "success";
      } else {
        return "failure";
      }
    } catch (e) {
      print("exception caught while sending the email: ${e.toString()}");
    }
    return "failure";
  }
}
