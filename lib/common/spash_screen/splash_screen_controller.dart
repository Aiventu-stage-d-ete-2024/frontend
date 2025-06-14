import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends ChangeNotifier {
  SplashScreenController();

  Future<bool?> initSplash() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    final userModel = sp.getString('userModel');

    await Future.delayed(const Duration(seconds: 3));


    return  userModel != null ? true : false;
  }
}