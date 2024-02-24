import 'package:cricketapp/models/match_info.dart';
import 'package:cricketapp/models/score_card.dart';

class MatchScoreCard {
  late MatchInfo matchInfo;
  late List<ScoreCard> scorecard;

  MatchScoreCard() {
    matchInfo = MatchInfo();
    scorecard = [];
  }

  MatchScoreCard.fromJson(Map<String, dynamic> json) {
    matchInfo = MatchInfo.fromJson(json);
    scorecard = json["scorecard"] == null ? [] : json["scorecard"].map<ScoreCard>((element) => ScoreCard.fromJson(element)).toList();
  }
}
