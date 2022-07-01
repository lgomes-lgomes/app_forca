import 'package:app_forca/controller/letter_box_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagesForca extends StatelessWidget {
  const ImagesForca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> imagePathList = [
      'assets/forca1.png',
      'assets/forca2.png',
      'assets/forca3.png',
      'assets/forca4.png',
      'assets/forca5.png',
      'assets/forca6.png',
      'assets/forca7.png',
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<LetterBoxController>(
          builder: (_, controller, __) {
            if (controller.teste == 0) {
              controller.iniciar();
            }
            return Column(
              children: [
                Image.asset(
                  imagePathList[controller.errorCounter],
                  width: constraints.maxWidth,
                  height: 180,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 60,
                      width: constraints.maxWidth,
                      child: Align(
                        alignment: Alignment.center,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.listaAcertos.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 4, right: 4),
                              child: Text(
                                controller.listaAcertos[index].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
