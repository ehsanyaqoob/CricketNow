class Legend {
  late String resource;
  late int id;
  late int stageId;
  late int seasonId;
  late int leagueId;
  late int position;
  late String description;
  late DateTime? updatedAt;

  Legend() {
    resource = "";
    id = 0;
    stageId = 0;
    seasonId = 0;
    leagueId = 0;
    position = 0;
    description = "";
    updatedAt = null;
  }

  Legend.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    stageId = json['stage_id'] ?? 0;
    seasonId = json['season_id'] ?? 0;
    leagueId = json['league_id'] ?? 0;
    position = json['position'] ?? 0;
    description = json['description'] ?? "";
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at'].toString()) : null;
  }
}
