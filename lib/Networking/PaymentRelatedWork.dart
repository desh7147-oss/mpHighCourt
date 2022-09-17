import 'package:flutter/foundation.dart';
import 'package:hcabaj/Utils/sharedPrefHelper.dart';

class PaymentRelatedWork {
  static Future doPaymentRelatedStuff(
      int amount, int planId, int userId) async {
    try {
      String userId = SharedPrefHelper.shared.getString("id").toString();
      String uri =
          "https://hcabaj.org/API/newrazarpay/payment-page.php?amount=${amount}&plan_id=${planId}&user_id=${userId}";
    } catch (e) {
      debugPrint("exception while payment: ${e.toString()}");
    }
  }
}
