class SeriesPoint {
  late String teamName;
  late String shortname;
  late String img;
  late int matches;
  late int wins;
  late int loss;
  late int ties;
  late int nr;

  SeriesPoint() {
    teamName = "";
    shortname = "";
    img = "";
    matches = 0;
    wins = 0;
    loss = 0;
    ties = 0;
    nr = 0;
  }

  SeriesPoint.fromJson(Map<String, dynamic> json) {
    teamName = json["teamname"] ?? "";
    shortname = json["shortname"] ?? "";
    img = json["img"] ?? "";
    matches = json["matches"] ?? "";
    wins = json["wins"] ?? "";
    loss = json["loss"] ?? "";
    ties = json["ties"];
    nr = json["nr"];
  }
}
