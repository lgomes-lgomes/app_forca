import 'package:firebase_dart/firebase_dart.dart';

class FirebaseInit {
  
  static const firebaseConfig = {
    'apiKey': "AIzaSyB7GVDeEoI9avI_9Do99M_fC4W08ogeF9w",
    'authDomain': "forca-api.firebaseapp.com",
    'projectId': "forca-api",
    'storageBucket': "forca-api.appspot.com",
    'messagingSenderId': "684413804998",
    'appId': "1:684413804998:web:e6571dde73d638df9a52c7"
  };
  
  static Future<FirebaseApp> initApp() async {

    late FirebaseApp app;

    try {
      app = Firebase.app();
    } catch (e) {
      app = await Firebase.initializeApp(
          options: FirebaseOptions.fromMap(firebaseConfig));
    }

    return app;
  }

  static Future<FirebaseAuth> authInstance() async {
    late FirebaseAuth firebaseAuth;

    try{
      await initApp().then((value) => firebaseAuth = FirebaseAuth.instanceFor(app: value));
    } catch(e){
      print('teste');
    }

    return firebaseAuth;
  }
}
