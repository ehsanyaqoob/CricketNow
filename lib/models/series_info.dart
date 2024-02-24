import 'package:cricketapp/models/match_info.dart';
import 'package:cricketapp/models/series.dart';

class SeriesInfo {
  late Series info;
  late List<MatchInfo> matchList;

  SeriesInfo() {
    info = Series();
    matchList = [];
  }

  SeriesInfo.fromJson(Map<String, dynamic> json) {
    info = Series.fromJson(json["info"]);
    matchList = json["matchList"] == null ? [] : json["matchList"].map<MatchInfo>((element) => MatchInfo.fromJson(element)).toList();
  }
}
