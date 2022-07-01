// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:app_forca/api/player_service.dart';
import 'package:app_forca/controller/letter_box_controller.dart';
import 'package:app_forca/widgets/letter_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LetterPicker extends StatelessWidget {

  PlayerService playerService = PlayerService();


  List<String> letras = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<LetterBoxController>(
          builder: (_, controller, __) {
            if (controller.terminou == false) {
              return Wrap(
                spacing: 5,
                alignment: WrapAlignment.center,
                runSpacing: 5,
                children: List.generate(
                  letras.length,
                  (index) => LetterBox(
                    letra: letras[index].toUpperCase(),
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  Text('A Palavra era: ${controller.palavra}'),
                  ElevatedButton(
                    onPressed: () {
                      LetterBoxController.reset(context);
                    },
                    child: const Text('JOGAR NOVAMENTE'),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
