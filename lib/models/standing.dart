import 'package:cricketapp/models/legend.dart';
import 'package:cricketapp/models/local_team.dart';

class Standing {
  late String resource;
  late int legendId;
  late int teamId;
  late int stageId;
  late int seasonId;
  late int leagueId;
  late int position;
  late int points;
  late int played;
  late int won;
  late int lost;
  late int draw;
  late int noResult;
  late int runsFor;
  late double oversFor;
  late int runsAgainst;
  late double oversAgainst;
  late double netToRunRate;
  late List<String> recentForm;
  late Legend legend;
  late LocalTeam team;

  Standing() {
    resource = "";
    legendId = 0;
    teamId = 0;
    stageId = 0;
    seasonId = 0;
    leagueId = 0;
    position = 0;
    points = 0;
    played = 0;
    won = 0;
    lost = 0;
    draw = 0;
    noResult = 0;
    runsFor = 0;
    oversFor = 0;
    runsAgainst = 0;
    oversAgainst = 0;
    netToRunRate = 0;
    recentForm = [];
    legend = Legend();
    team = LocalTeam();
  }

  Standing.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    legendId = json['legend_id'] ?? 0;
    teamId = json['team_id'] ?? 0;
    stageId = json['stage_id'] ?? 0;
    seasonId = json['season_id'] ?? 0;
    leagueId = json['league_id'] ?? 0;
    position = json['position'] ?? 0;
    points = json['points'] ?? 0;
    played = json['played'] ?? 0;
    won = json['won'] ?? 0;
    lost = json['lost'] ?? 0;
    draw = json['draw'] ?? 0;
    noResult = json['noresult'] ?? 0;
    runsFor = json['runs_for'] ?? 0;
    oversFor = json['overs_for'] == null ? 0 : json['overs_for'].toDouble();
    runsAgainst = json['runs_against'] ?? 0;
    oversAgainst = json['overs_against'] == null ? 0 : json['overs_against'].toDouble();
    netToRunRate = json['netto_run_rate'] == null ? 0 : json['netto_run_rate'].toDouble();
    recentForm = json['recent_form'] == null ? [] : List<String>.from(json['recent_form']);
    legend = json['legend'] != null ? Legend.fromJson(json['legend']) : Legend();
    team = LocalTeam();
  }
}
