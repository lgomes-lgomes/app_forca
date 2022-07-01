// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:app_forca/controller/letter_box_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LetterBox extends StatefulWidget {
  String letra;

  LetterBox({
    Key? key,
    required this.letra,
  }) : super(key: key);

  @override
  State<LetterBox> createState() => LetterBoxState(letra: letra);
}

class LetterBoxState extends State<LetterBox> {
  Color color = Colors.blue;
  String letra;
  bool enable;
  LetterBoxState({required this.letra}) : enable = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.2,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Consumer<LetterBoxController>(
        builder: (_, controller, __) {
          return TextButton(
            onPressed: () {
              if (enable) {
                controller.verificaAcerto(this, context);
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                color,
              ),
            ),
            child: Text(
              widget.letra,
              style: Theme.of(context).textTheme.headline1,
            ),
          );
        },
      ),
    );
  }

  void setEnable(bool enable) {
    this.enable = enable;
  }
}
