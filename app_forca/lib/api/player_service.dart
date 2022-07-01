import 'package:app_forca/api/api_constants.dart';
import 'package:app_forca/api/auth_service.dart';
import 'package:app_forca/api/firebase/firebase_init.dart';
import 'package:app_forca/model/player.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class PlayerService {
  Future<Player> getPlayer() async {

    AuthService _authService = AuthService();

    Map? user = await _authService.isLoggedIn();
    String? email;

    if(user != null){
      email = user['email'];
    }
    
    var url = Uri.parse(
        ApiConstants.playersUrl + ApiConstants.getPlayer + '?email=$email');
    final Dio _dio = Dio();

    var responseData = "";

    try {
      final response = await _dio.get<String>(url.toString());
      responseData = response.data!;
    } on DioError catch (e) {
      developer.log(e.message);
    }

    final Player _player = playerFromJson(responseData);

    return _player;
  }

  Future<void> addMatch (String result) async {

    AuthService _authService = AuthService();

    Map? user = await _authService.isLoggedIn();

    String? email;
    
    if(user != null){
      email = user['email'];
    }

    var url =
        Uri.parse('http://192.168.15.60:80/matches/add-match?email=$email&result=$result');

    final Dio _dio = Dio();

    try {
      _dio.postUri(url);
    } on DioError catch(e){
      developer.log(e.message);
    }
  } 
}
