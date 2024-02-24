import 'package:cricketapp/models/score.dart';
import 'package:cricketapp/models/team_info.dart';
import 'package:intl/intl.dart';

class MatchInfo {
  late String id;
  late String name;
  late String matchType;
  late String status;
  late String venue;
  late List<dynamic> teams;
  late List<Score> score;
  late List<TeamInfo> teamInfo;
  late String seriesId;
  late DateTime? date;
  late String formattedTime;
  late String formattedDate;
  late bool fantasyEnabled;
  late bool bbbEnabled;
  late bool hasSquad;
  late bool matchStarted;
  late bool matchEnded;
  late String tossWinner;
  late String tossChoice;
  late String matchWinner;

  MatchInfo() {
    id = "";
    name = "";
    matchType = "";
    status = "";
    venue = "";
    teams = [];
    score = [];
    teamInfo = [];
    seriesId = "";
    date = null;
    formattedTime = "";
    formattedDate = "";
    fantasyEnabled = false;
    bbbEnabled = false;
    hasSquad = false;
    matchStarted = false;
    matchEnded = false;
    tossWinner = "";
    tossChoice = "";
    matchWinner = "";
  }

  MatchInfo.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    name = json["name"] ?? "";
    matchType = json["matchType"] ?? "";
    status = json["status"] ?? "";
    venue = json["venue"] ?? "";
    teams = json["teams"] ?? "";
    score = json["score"] == null ? [] : json["score"].map<Score>((obj) => Score.fromJson(obj)).toList();
    teamInfo = json["teamInfo"] == null ? [] : json["teamInfo"].map<TeamInfo>((obj) => TeamInfo.fromJson(obj)).toList();
    seriesId = json["series_id"] ?? "";
    date = _parseDate(json["date"]);
    formattedTime = _toTime(json["dateTimeGMT"]);
    formattedDate = _toDate(json["dateTimeGMT"]);
    fantasyEnabled = json["fantasyEnabled"] ?? false;
    bbbEnabled = json["bbbEnabled"] ?? false;
    hasSquad = json["hasSquad"] ?? false;
    matchStarted = json["matchStarted"] ?? false;
    matchEnded = json["matchEnded"] ?? false;
    tossWinner = json["tossWinner"] ?? "";
    tossChoice = json["tossChoice"] ?? "";
    matchWinner = json["matchWinner"] ?? "";
  }

  DateTime? _parseDate(dynamic date) {
    try {
      return DateTime.parse(date.toString());
    } catch (e) {
      return null;
    }
  }

  String _toDate(dynamic date) {
    if (date == null) {
      return "";
    }
    try {
      return DateFormat("dd MMM yyyy").format(DateTime.parse(date.toString()));
    } catch (e) {
      return date;
    }
  }

  String _toTime(dynamic date) {
    if (date == null) {
      return "";
    }
    try {
      return DateFormat("hh:mm aa").format(DateTime.parse(date.toString()));
    } catch (e) {
      return "";
    }
  }
}
