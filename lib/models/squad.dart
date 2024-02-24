import 'package:cricketapp/models/player.dart';

class Squad {
  late String teamName;
  late String shortname;
  late String img;
  late List<Player> players;

  Squad() {
    teamName = "";
    shortname = "";
    img = "";
    players = [];
  }

  Squad.fromJson(Map<String, dynamic> json) {
    teamName = json["teamName"] ?? "";
    shortname = json["shortname"] ?? "";
    img = json["img"] ?? "";
    players = json["players"] == null ? [] : json["players"].map<Player>((e) => Player.fromJson(e)).toList();
  }
}
