import 'package:cricketapp/models/batting.dart';
import 'package:cricketapp/models/bowling.dart';
import 'package:cricketapp/models/catching.dart';
import 'package:cricketapp/models/extras.dart';
import 'package:cricketapp/models/total.dart';

class ScoreCard {
  late List<Batting> batting;
  late List<Bowling> bowling;
  late List<Catching> catching;
  late Extras extras;
  late Totals totals;
  late String inning;

  ScoreCard() {
    batting = [];
    bowling = [];
    catching = [];
    extras = Extras();
    totals = Totals();
    inning = "";
  }

  ScoreCard.fromJson(Map<String, dynamic> json) {
    batting = json["batting"] == null ? [] : json["batting"].map<Batting>((e) => Batting.fromJson(e)).toList();
    bowling = json["bowling"] == null ? [] : json["bowling"].map<Bowling>((e) => Bowling.fromJson(e)).toList();
    catching = json["catching"] == null ? [] : json["catching"].map<Catching>((e) => Catching.fromJson(e)).toList();
    extras = json["extras"] == null ? Extras() : Extras.fromJson(json["extras"]);
    totals = json["totals"] == null ? Totals() : Totals.fromJson(json["totals"]);
    inning = json["inning"] ?? "";
  }
}
