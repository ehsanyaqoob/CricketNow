import 'package:cricketapp/models/local_team.dart';

class TeamRanking {
  late String resource;
  late String type;
  late List<LocalTeam> teams;

  TeamRanking() {
    resource = "";
    type = "";
    teams = [];
  }

  TeamRanking.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    type = json['type'] ?? "";
    teams = json["team"] == null ? [] : json["team"].map<LocalTeam>((obj) => LocalTeam.fromJson(obj)).toList();
  }
}
