import 'package:cricketapp/models/league.dart';

class Season {
  late String resource;
  late int id;
  late int leagueId;
  late int seasonId;
  late String name;
  late String code;
  late String type;
  late bool standings;
  late League league;

  Season() {
    resource = "";
    id = 0;
    leagueId = 0;
    seasonId = 0;
    name = "";
    code = "";
    type = "";
    standings = false;
    league = League();
  }

  Season.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    leagueId = json['league_id'] ?? 0;
    seasonId = json['season_id'] ?? 0;
    name = json['name'] ?? "";
    code = json['code'] ?? "";
    type = json['type'] ?? "";
    standings = json['standings'] ?? false;
    league = json['league'] != null ? League.fromJson(json['league']) : League();
  }
}
