import 'package:cricketapp/models/local_team.dart';
import 'package:cricketapp/models/score_ball_by_ball.dart';
import 'package:cricketapp/models/team_squad.dart';

class Ball {
  late String resource;
  late int id;
  late int fixtureId;
  late int teamId;
  late int balls;
  late int overs;
  late String scoreboard;
  late int batsmanOneOnCreezeId;
  late int batsmanTwoOnCreezeId;
  late int batsmanId;
  late int bowlerId;
  late int batsmanoutId;
  late int catchstumpId;
  late int runoutById;
  late int scoreId;
  late TeamSquad batsman;
  late TeamSquad bowler;
  late ScoreBallByBall score;
  late LocalTeam team;
  late DateTime? updatedAt;
  late bool isOvered;

  Ball() {
    resource = "";
    id = 0;
    fixtureId = 0;
    teamId = 0;
    balls = 0;
    overs = 0;
    scoreboard = "";
    batsmanOneOnCreezeId = 0;
    batsmanTwoOnCreezeId = 0;
    batsmanId = 0;
    bowlerId = 0;
    batsmanoutId = 0;
    catchstumpId = 0;
    runoutById = 0;
    scoreId = 0;
    batsman = TeamSquad();
    bowler = TeamSquad();
    score = ScoreBallByBall();
    team = LocalTeam();
    updatedAt = null;
    isOvered = false;
  }

  Ball.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    fixtureId = json['fixture_id'] ?? 0;
    teamId = json['team_id'] ?? 0;
    balls = _getBall(json['ball']);
    overs = _getOver(json['ball']);
    scoreboard = json['scoreboard'] ?? "";
    batsmanOneOnCreezeId = json['batsman_one_on_creeze_id'] ?? 0;
    batsmanTwoOnCreezeId = json['batsman_two_on_creeze_id'] ?? 0;
    batsmanId = json['batsman_id'] ?? 0;
    bowlerId = json['bowler_id'] ?? 0;
    batsmanoutId = json['batsmanout_id'] ?? 0;
    catchstumpId = json['catchstump_id'] ?? 0;
    runoutById = json['runout_by_id'] ?? 0;
    scoreId = json['score_id'] ?? 0;
    batsman = json['batsman'] != null
        ? TeamSquad.fromJson(json['batsman'])
        : TeamSquad();
    bowler = json['bowler'] != null
        ? TeamSquad.fromJson(json['bowler'])
        : TeamSquad();
    score = json['score'] != null
        ? ScoreBallByBall.fromJson(json['score'])
        : ScoreBallByBall();
    team =
        json['team'] != null ? LocalTeam.fromJson(json['team']) : LocalTeam();
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    isOvered = balls == 1;
  }

  int _getBall(dynamic data) {
    if (data == null) {
      return 0;
    }

    try {
      final v = data.toString().split(".")[1];
      return int.parse(v);
    } catch (e) {
      return 0;
    }
  }

  int _getOver(dynamic data) {
    if (data == null) {
      return 0;
    }

    try {
      final v = data.toString().split(".")[0];
      return int.parse(v) + 1;
    } catch (e) {
      return 0;
    }
  }
}
