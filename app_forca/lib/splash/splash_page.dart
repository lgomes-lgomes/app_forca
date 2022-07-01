import 'package:app_forca/api/auth_service.dart';
import 'package:app_forca/api/firebase/firebase_init.dart';
import 'package:app_forca/home/home_page.dart';
import 'package:app_forca/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dart/core.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthService _authService = AuthService();

  late Future<bool> logado = _getData();

  @override
  void initState() {
    super.initState();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future<bool> _getData() async {
    try{
      Future<Map> _player = Future.value(await _authService.isLoggedIn());
      setState(() {});

      if (_player != null) {
        return true;
      } else {
        return false;
      }
    } catch (e){
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: FutureBuilder(
        future: logado,
        builder: ((context, AsyncSnapshot<bool> logado) {
          if (logado.data != null && logado.data == true) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                ModalRoute.withName(''),
              );
            });
          }
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}
