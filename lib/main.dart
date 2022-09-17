import 'package:flutter/material.dart';
import 'package:hcabaj/Screens/splashScreen.dart';
import 'package:hcabaj/Utils/BasePaths.dart';

import 'Utils/sharedPrefHelper.dart';

// entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefHelper.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        scaffoldMessengerKey: snackbarKey,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
