import 'package:cricketapp/models/team_squad.dart';

class Bowling {
  late String resource;
  late int id;
  late int sort;
  late int fixtureId;
  late int teamId;
  late bool active;
  late String scoreboard;
  late int playerId;
  late double overs;
  late int medians;
  late int runs;
  late int wickets;
  late int wide;
  late int noBall;
  late double rate;
  late DateTime? updatedAt;
  late TeamSquad bowler;

  Bowling() {
    resource = "";
    id = 0;
    sort = 0;
    fixtureId = 0;
    teamId = 0;
    active = false;
    scoreboard = "";
    playerId = 0;
    overs = 0;
    medians = 0;
    runs = 0;
    wickets = 0;
    wide = 0;
    noBall = 0;
    rate = 0;
    updatedAt = null;
    bowler = TeamSquad();
  }

  Bowling.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'];
    sort = json['sort'];
    fixtureId = json['fixture_id'];
    teamId = json['team_id'];
    active = json['active'] ?? false;
    scoreboard = json['scoreboard'] ?? "";
    playerId = json['player_id'];
    overs = json['overs'] == null ? 0 : json['overs'].toDouble();
    medians = json['medians'] ?? 0;
    runs = json['runs'] ?? 0;
    wickets = json['wickets'] ?? 0;
    wide = json['wide'] ?? 0;
    noBall = json['noball'] ?? 0;
    rate = json['rate'] == null ? 0 : json['rate'].toDouble();
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at'].toString()) : null;
    bowler = TeamSquad.fromJson(json['bowler']);
  }
}
