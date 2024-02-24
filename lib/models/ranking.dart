class Ranking {
  late String resource;
  late int matches;
  late int position;
  late int points;
  late int rating;

  Ranking() {
    resource = "";
    matches = 0;
    position = 0;
    points = 0;
    rating = 0;
  }

  Ranking.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    matches = json['id'] ?? 0;
    position = json['position'] ?? 0;
    points = json['points'] ?? 0;
    rating = json['rating'] ?? "";
  }
}
