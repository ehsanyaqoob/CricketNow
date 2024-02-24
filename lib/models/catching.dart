import 'package:cricketapp/models/player.dart';

class Catching {
  late int stumped;
  late int runout;
  late int catches;
  late Player catcher;

  Catching() {
    stumped = 0;
    runout = 0;
    catches = 0;
    catcher = Player();
  }

  Catching.fromJson(Map<String, dynamic> json) {
    stumped = json["stumped"] ?? 0;
    runout = json["runout"] ?? 0;
    catches = json["catches"] ?? 0;
    catcher = json["catcher"] == null ? Player() : Player.fromJson(json["catcher"]);
  }
}
