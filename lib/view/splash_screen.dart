import 'package:flutter/material.dart';
import 'package:note_firebase/controller/splash_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashScreenProvider>(context, listen: false)
        .navigateToHome(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'MY NOTE APP',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
    );
  }
}
