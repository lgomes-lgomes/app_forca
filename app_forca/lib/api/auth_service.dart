import 'dart:convert';

import 'package:app_forca/api/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<Map?> isLoggedIn() async {
    var url = Uri.parse(ApiConstants.authUrl + ApiConstants.userLoggedIn);

    Dio _dio = Dio();
    Response? response;

    try {
      await _dio.getUri(url).then((value) => response = value);
    } on DioError catch (e) {
      print(e.message);
    }

    bool logado = false;
    Map<dynamic, dynamic>? user;


    if (response!.data['user'] == null) {
      logado = false;
    } else {
      user = response!.data['user'];
      logado = response!.data['logado'];
    }
    
    return user;
  }

  Future<int?>logout() async {
    var url = Uri.parse(ApiConstants.authUrl + ApiConstants.userLogout);

    Dio _dio = Dio();
    Response? response;
    int? responseCode;

    try {
      response = await _dio.post(url.toString());
      responseCode = response.statusCode;
    } on DioError catch (e) {
      responseCode =  e.response!.statusCode;
      print(e.message);
    }

    return responseCode;
  }

  login(String email, String password) async {
    var url = Uri.parse(ApiConstants.authUrl + ApiConstants.loginUser);

    Dio _dio = Dio();

    try {
      await _dio
          .post(url.toString(), data: {'email': email, 'password': password});
    } on DioError catch (e) {
      print(e.message);
    }
  }

  register(String email, String password, String name) async {
    var url = Uri.parse(ApiConstants.authUrl + ApiConstants.registerUser);

    Dio _dio = Dio();

    try {
      await _dio.post(
        url.toString(),
        data: {'email': email, 'password': password, 'name': name},
      );
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
