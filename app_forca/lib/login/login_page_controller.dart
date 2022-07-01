import 'package:app_forca/api/auth_service.dart';
import 'package:app_forca/home/home_page.dart';
import 'package:app_forca/login/login_page.dart';
import 'package:app_forca/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPageController {
  Future<void> loginUser(String email, String password, BuildContext context) async {

    AuthService authService = AuthService();

    await authService.login(email, password);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => SplashPage()),
        ));
  }
}
