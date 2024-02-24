class Runs {
  late String resource;
  late int id;
  late int fixtureId;
  late int teamId;
  late int inning;
  late int score;
  late int wickets;
  late double overs;
  late String pp1;
  late String pp2;
  late String pp3;
  late DateTime? updatedAt;

  Runs() {
    resource = "";
    id = 0;
    fixtureId = 0;
    teamId = 0;
    inning = 0;
    score = 0;
    wickets = 0;
    overs = 0;
    pp1 = "";
    pp2 = "";
    pp3 = "";
    updatedAt = null;
  }

  Runs.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    fixtureId = json['fixture_id'] ?? 0;
    teamId = json['team_id'] ?? 0;
    inning = json['inning'] ?? 0;
    score = json['score'] ?? 0;
    wickets = json['wickets'] ?? 0;
    overs = json['overs'] == null ? 0 : json['overs'].toDouble();
    pp1 = json['pp1'] ?? "";
    pp2 = json['pp2'] ?? "";
    pp3 = json['pp3'] ?? "";
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at'].toString()) : null;
  }
}
