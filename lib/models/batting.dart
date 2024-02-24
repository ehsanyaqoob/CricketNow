import 'package:cricketapp/models/team_squad.dart';

class Batting {
  late String resource;
  late int id;
  late int sort;
  late int fixtureId;
  late int teamId;
  late bool active;
  late String scoreboard;
  late int playerId;
  late int ball;
  late int scoreId;
  late int score;
  late int fourX;
  late int sixX;
  late int catchStumpPlayerId;
  late int runOutById;
  late int batsManOutId;
  late int bowlingPlayerId;
  late int fowScore;
  late double fowBalls;
  late double rate;
  late DateTime? updatedAt;
  late TeamSquad batsman;

  Batting() {
    resource = "";
    id = 0;
    sort = 0;
    fixtureId = 0;
    teamId = 0;
    active = false;
    scoreboard = "";
    playerId = 0;
    ball = 0;
    scoreId = 0;
    score = 0;
    fourX = 0;
    sixX = 0;
    catchStumpPlayerId = 0;
    runOutById = 0;
    batsManOutId = 0;
    bowlingPlayerId = 0;
    fowScore = 0;
    fowBalls = 0;
    rate = 0;
    updatedAt = null;
    batsman = TeamSquad();
  }

  Batting.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'];
    sort = json['sort'];
    fixtureId = json['fixture_id'];
    teamId = json['team_id'];
    active = json['active'];
    scoreboard = json['scoreboard'] ?? "";
    playerId = json['player_id'] ?? 0;
    ball = json['ball'] ?? 0;
    scoreId = json['score_id'] ?? 0;
    score = json['score'] ?? 0;
    fourX = json['four_x'] ?? 0;
    sixX = json['six_x'] ?? 0;
    catchStumpPlayerId = json['catch_stump_player_id'] ?? 0;
    runOutById = json['runout_by_id'] ?? 0;
    batsManOutId = json['batsmanout_id'] ?? 0;
    bowlingPlayerId = json['bowling_player_id'] ?? 0;
    fowScore = json['fow_score'] ?? 0;
    fowBalls = json['fow_balls'] == null ? 0 : json['fow_balls'].toDouble() ?? 0;
    rate = json['rate'] == null ? 0 : json['rate'].toDouble();
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    batsman = TeamSquad.fromJson(json['batsman']);
  }
}
