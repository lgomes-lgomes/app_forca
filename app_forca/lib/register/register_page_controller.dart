import 'package:app_forca/api/auth_service.dart';
import 'package:app_forca/login/login_page_controller.dart';
import 'package:app_forca/splash/splash_page.dart';
import 'package:flutter/material.dart';

class RegisterPageController {
  Future<void> registerUser(
    String email, String password, String name, BuildContext context) async{

    final AuthService authService = AuthService();
    final LoginPageController loginPageController = LoginPageController();

    await authService.register(email, password, name);
    loginPageController.loginUser(email, password, context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => SplashPage()),
      ),
    );
  }
}
