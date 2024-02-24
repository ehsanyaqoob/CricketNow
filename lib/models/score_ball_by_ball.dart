class ScoreBallByBall {
  late String resource;
  late int id;
  late String name;
  late int runs;
  late bool four;
  late bool six;
  late int bye;
  late int legBye;
  late int noball;
  late int noballRuns;
  late bool isWicket;
  late bool ball;
  late bool out;

  ScoreBallByBall() {
    resource = "";
    id = 0;
    name = "";
    runs = 0;
    four = false;
    six = false;
    bye = 0;
    legBye = 0;
    noball = 0;
    noballRuns = 0;
    isWicket = false;
    ball = false;
    out = false;
  }

  ScoreBallByBall.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    runs = json['runs'] ?? 0;
    four = json['four'] ?? false;
    six = json['six'] ?? false;
    bye = json['bye'] ?? 0;
    legBye = json['leg_bye'] ?? 0;
    noball = json['noball'] ?? 0;
    noballRuns = json['noball_runs'] ?? 0;
    isWicket = json['is_wicket'] ?? false;
    ball = json['ball'] ?? false;
    out = json['out'] ?? false;
  }
}
