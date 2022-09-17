import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGateWayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl:
            "https://hcabaj.org/API/newrazarpay/payment-page.php?amount=1000&plan_id=2&user_id=3",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
