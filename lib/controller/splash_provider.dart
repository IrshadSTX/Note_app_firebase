import 'package:flutter/material.dart';

import '../view/home_screen.dart';

class SplashScreenProvider with ChangeNotifier {
  Future<void> navigateToHome(BuildContext context) async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }
}
