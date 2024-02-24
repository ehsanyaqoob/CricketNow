class Score {
  late int r;
  late int w;
  late double o;
  late String inning;

  Score() {
    r = 0;
    w = 0;
    o = 0;
    inning = "";
  }

  Score.fromJson(Map<String, dynamic> json) {
    r = json["r"];
    w = json["w"];
    o = json["o"].toDouble();
    inning = json["inning"] ?? "";
  }
}
