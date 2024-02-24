class Totals {
  late int r;
  late double o;
  late int w;
  late double rr;

  Totals() {
    r = 0;
    o = 0;
    w = 0;
    rr = 0.0;
  }

  Totals.fromJson(Map<String, dynamic> json) {
    r = json["r"] ?? 0;
    o = json["o"] == null ? 0 : json["o"].toDouble();
    w = json["w"] ?? 0;
    rr = json["rr"] == null ? 0 : json["rr"].toDouble();
  }
}
