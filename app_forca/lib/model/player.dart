
// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

import 'dart:convert';

import 'package:app_forca/model/match_model.dart';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
  Player({
    required this.email,
    this.matchesMap,
    required this.name,
    this.matchesList,
  });

  String email;
  Map<String, Map<String, int>>? matchesMap;
  String name;
  List<MatchModel>? matchesList = [];



  factory Player.fromJson(Map<String, dynamic> json) {

    if(json['matches'] == null){
      return Player(
        email: json['email'],
        name: json['name'],
      );
    } else {
      return Player(
        email: json["email"],
        matchesMap: Map.from(json["matches"]).map((k, v) =>
            MapEntry<String, Map<String, int>>(
                k, Map.from(v).map((k, v) => MapEntry<String, int>(k, v)))),
        name: json["name"],
      );
    }
  } 
  Map<String, dynamic> toJson() => {
    "email": email,
    "matches": Map.from(matchesMap!).map((k, v) => MapEntry<String, dynamic>(k, Map.from(v).map((k, v) => MapEntry<String, dynamic>(k, v)))),
    "name": name,
  };
}