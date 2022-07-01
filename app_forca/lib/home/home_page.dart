import 'package:app_forca/api/auth_service.dart';
import 'package:app_forca/controller/letter_box_controller.dart';
import 'package:app_forca/player_page/player_page.dart';
import 'package:app_forca/widgets/images_forca.dart';
import 'package:app_forca/widgets/letter_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Center(
      child: Consumer<LetterBoxController>(
        builder: (_, controller, __) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(controller.textoAppBar),
              backgroundColor: controller.corAppBar,
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Future.delayed(Duration.zero, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlayerPage(),
                        ),
                      );
                    });
                  },
                  child: const Icon(
                    Icons.person,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: controller.corAppBar,
                    elevation: 0,
                  ),
                ),
              ],
            ),
            body: LayoutBuilder(builder: (_, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.minHeight,
                  minWidth: constraints.minWidth,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const ImagesForca(),
                        LetterPicker(),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
