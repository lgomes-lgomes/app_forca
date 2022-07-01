import 'dart:math';

import 'package:app_forca/api/player_service.dart';
import 'package:app_forca/main.dart';
import 'package:app_forca/widgets/letter_box.dart';
import 'package:flutter/material.dart';

class LetterBoxController extends ChangeNotifier {
  Color color = Colors.blue;
  Color colorAtt = Colors.red;

  bool terminou = false;

  String textoAppBar = 'COMEÇOU';
  Color corAppBar = Colors.blue;

  int errorCounter = 0;

  String palavra = '';
  List<String> listaAcertos = [];
  List<String> palavrasJogadas = [];
  int teste = 0;

  void verificaAcerto(LetterBoxState letterBoxState, BuildContext context) {

    String letra = letterBoxState.letra.toLowerCase();


    if (palavra.contains(letra)) {
      letterBoxState.color = Colors.green;
      corAppBar = Colors.green;
      textoAppBar = 'ACERTOU';

      List<int> indexes = _checkIndex(letra);

      for (int i = 0; i < indexes.length; i++) {
        listaAcertos[indexes[i]] = letra;
      }

      if (!listaAcertos.contains('_')) {
        terminou = true;
        corAppBar = const Color.fromARGB(255, 36, 187, 41);
        textoAppBar = 'VOCÊ VENCEU';
        PlayerService _playerService = PlayerService();
        _playerService.addMatch('1');
        notifyListeners();
      }

      letterBoxState.setEnable(false);

    } else {
      letterBoxState.color = Colors.red;
      corAppBar = const Color.fromARGB(255, 241, 89, 78);
      textoAppBar = 'VOCÊ ERROU';
      if (errorCounter < 5) {
        errorCounter++;
      } else {
        errorCounter = 0;
        terminou = true;
        textoAppBar = 'VOCÊ PERDEU';
        PlayerService _playerService = PlayerService();
        _playerService.addMatch('0');
        notifyListeners();
      }

      letterBoxState.setEnable(false);
    }

    teste = 1;

    notifyListeners();
  }

  static void reset(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => const MyApp(),
      ),
    );
  }

  List<int> _checkIndex(String letra) {
    List<int> indexes = [];

    for (int i = 0; i < palavra.length; i++) {
      if (palavra[i] == letra) {
        indexes.add(i);
      }
    }

    return indexes;
  }

  void geraPalavra(){
    List<String> palavras = [
      'Cadeia',
      'Solto',
      'Utilidade',
      'Denso',
      'Cinza',
      'Branco',
      'Padrasto',
      'Pastilha',
      'Baixo',
      'Montanhas',
      'Doente',
      'Felicidade',
      'Costeletas',
      'Cuidado',
      'Cordeiro',
      'Nuca',
      'Sentimento',
      'Freio',
      'Cama',
      'Manusear',
      'Bumerangue',
      'Calculadora',
      'Morcego',
      'Embaixador',
      'Fora',
      'Fratura',
      'Boca',
      'Torradeira',
      'Vivo',
      'Hipnotizar',
      'Raiz',
      'Silenciador',
      'Abrigo',
      'Outono',
      'Fogueira',
      'Escultor',
      'Perfil',
      'Estrutura',
      'Decifrar',
      'Aposta',
      'Tabela',
      'Flautas',
      'Base',
      'Norte',
      'Imenso',
      'Chama',
      'Segundo',
      'Quiosque',
      'Guardanapo',
      'Artista',
      'Captura',
      'Forte',
      'Londres',
      'Lagoa',
      'Jogos',
      'Livros',
      'Subida',
      'Narina',
      'Piada',
      'Joelho',
      'Estojo',
    ];

    var rng = Random();

    do{
      palavra = palavras[rng.nextInt(palavras.length)].toLowerCase();
    }while((palavrasJogadas.contains(palavra)));

  }

  void iniciar(){
    geraPalavra();
    listaAcertos = List.generate(palavra.length, (index) => '_');
  }
}
