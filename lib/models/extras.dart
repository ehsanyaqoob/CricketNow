class Extras {
  late int r;
  late int b;
  late int lb;
  late int w;
  late int nb;
  late int p;

  Extras() {
    r = 0;
    b = 0;
    lb = 0;
    w = 0;
    nb = 0;
    p = 0;
  }

  Extras.fromJson(Map<String, dynamic> json) {
    r = json["r"] ?? 0;
    b = json["b"] ?? 0;
    lb = json["lb"] ?? 0;
    w = json["w"] ?? 0;
    nb = json["nb"] ?? 0;
    p = json["p"] ?? 0;
  }
}
