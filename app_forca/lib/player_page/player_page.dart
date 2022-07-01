import 'package:app_forca/api/auth_service.dart';
import 'package:app_forca/api/player_service.dart';
import 'package:app_forca/model/match_model.dart';
import 'package:app_forca/model/player.dart';
import 'package:app_forca/splash/splash_page.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late Future<Player> _player = _getData();
  List<MatchModel> matchList = [];
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    matchesMapToList();
  }

  Future<Player> _getData() async {
    Future<Player> _player = Future.value(await PlayerService().getPlayer());
    await Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() {}));
    return _player;
  }

  void matchesMapToList() async {
    Player? player;
    try {
      await _player.then((value) => player = value);
    } catch (e) {
      player = null;
    }

    if (player != null) {
      if (player!.matchesMap != null) {
        player!.matchesMap!.forEach((key, value) {
          MatchModel model = MatchModel(id: key, result: value.values.first);

          matchList.add(model);

          player!.matchesList = matchList;
        });
      } else {
        matchList = [];
      }
    }
    try {
      _player = Future.value(player);
    } catch (e) {
      _player = Future.value(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PLAYER INFO'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<Player>(
            future: _player,
            builder: (BuildContext context, AsyncSnapshot<Player> player) {
              if (player.hasData) {
                if (player.data!.matchesMap != null) {
                  if (player.data!.matchesMap!.isNotEmpty) {
                    var playerData = player.data!;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            Text(
                              playerData.name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              playerData.email,
                              style: const TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: constraints.maxWidth / 2,
                              height: constraints.maxHeight / 4,
                              child: ListView.builder(
                                itemCount: player.data!.matchesMap!.length,
                                itemBuilder: (context, index) {
                                  int matchResult =
                                      playerData.matchesList![index].result;
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Card(
                                      color: matchResult == 1
                                          ? Colors.green
                                          : Colors.red,
                                      child: Center(
                                        child: Text(
                                          'GAME ${playerData.matchesList![index].id} : ${playerData.matchesList![index].result == 1 ? 'WIN' : 'LOSS'}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  const Text('STATS (WIN/LOSS)'),
                                  Text(
                                      '${playerData.matchesMap!.length} GAMES PLAYED'),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: SizedBox(
                                        height: constraints.maxHeight / 3,
                                        width: constraints.maxWidth / 2,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 30,
                                          value: winLoss(playerData),
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(
                                            Colors.green,
                                          ),
                                          backgroundColor: Colors.red,
                                        )),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      int? responseCode = await _authService.logout();

                                      if(responseCode != null){
                                        if(responseCode == 200){
                                          Navigator.of(context).pop();
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SplashPage(),
                                            ),
                                          );
                                        }   
                                      } else{
                                        print('erro no logout');
                                      }
                                    },
                                    child: const Text('LOGOUT'),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    var playerData = player.data!;
                    return Center(
                      child: Column(
                        children: [
                          Text(
                            playerData.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text(
                            playerData.email,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                const Text('STATS (WIN/LOSS)'),
                                const Text('NO GAMES HAVE BEEN PLAYED YET'),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    height: constraints.maxHeight / 3,
                                    width: constraints.maxWidth / 2,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 30,
                                      value: winLoss(playerData),
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _authService.logout();
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => SplashPage(),
                                        ),
                                      );
                                    });
                                  },
                                  child: const Text('LOGOUT'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  var playerData = player.data!;
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          playerData.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          playerData.email,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              const Text('STATS (WIN/LOSS)'),
                              const Text('NO GAMES HAVE BEEN PLAYED YET'),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  height: constraints.maxHeight / 3,
                                  width: constraints.maxWidth / 2,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 30,
                                    value: winLoss(playerData),
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _authService.logout();
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => SplashPage(),
                                      ),
                                    );
                                  });
                                },
                                child: const Text('LOGOUT'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }

  double winLoss(Player playerData) {
    double win = 0, loss = 0;

    if (playerData.matchesList != null) {
      for (var match in playerData.matchesList!) {
        if (match.result == 1) {
          win++;
        } else {
          loss--;
        }
      }
    } else {
      return 0;
    }

    double winLossSum = win + (-loss);
    double winLossRatio = win * 100 / winLossSum;

    return winLossRatio / 100;
  }
}
