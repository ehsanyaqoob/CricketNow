import 'package:cricketapp/models/ball.dart';
import 'package:cricketapp/models/batting.dart';
import 'package:cricketapp/models/bowling.dart';
import 'package:cricketapp/models/league.dart';
import 'package:cricketapp/models/local_team.dart';
import 'package:cricketapp/models/meta_data.dart';
import 'package:cricketapp/models/page_link.dart';
import 'package:cricketapp/models/runs.dart';
import 'package:cricketapp/models/stage.dart';
import 'package:cricketapp/models/team_dl_data.dart';
import 'package:cricketapp/models/venue.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Fixture {
  late String resource;
  late int id;
  late int leagueId;
  late int seasonId;
  late int stageId;
  late String round;
  late int localTeamId;
  late int visitorTeamId;
  late DateTime? startingAt;
  late String type;
  late bool live;
  late String status;
  late String note;
  late int venueId;
  late int tossWonTeamId;
  late int winnerTeamId;
  late String drawNoResult;
  late int firstUmpireId;
  late int secondUmpireId;
  late int tvUmpireId;
  late int refereeId;
  late int manOfMatchId;
  late int manOfSeriesId;
  late int totalOversPlayed;
  late String elected;
  late bool superOver;
  late bool followOn;
  late TeamDlData? localTeamDlData;
  late TeamDlData? visitorTeamDlData;
  late String rpcOvers;
  late String rpcTarget;
  late LocalTeam localTeam;
  late LocalTeam visitorTeam;
  late List<Runs> runs;
  late Venue venue;
  late PageLink links;
  late MetaData meta;
  late String formattedDate;
  late String time;
  late List<Bowling> bowling;
  late List<Batting> batting;
  late Stage stage;
  late List<Ball> balls;
  late League league;
  late Runs? runsLocal;
  late Runs? runsVisitor;
  late bool international;
  late bool showNativeAdd;

  Fixture() {
    resource = "";
    id = 0;
    leagueId = 0;
    seasonId = 0;
    stageId = 0;
    round = "";
    localTeamId = 0;
    visitorTeamId = 0;
    startingAt = null;
    type = "";
    live = false;
    status = "";
    note = "";
    venueId = 0;
    tossWonTeamId = 0;
    winnerTeamId = 0;
    drawNoResult = "";
    firstUmpireId = 0;
    secondUmpireId = 0;
    tvUmpireId = 0;
    refereeId = 0;
    manOfMatchId = 0;
    manOfSeriesId = 0;
    totalOversPlayed = 0;
    elected = "";
    superOver = false;
    followOn = false;
    localTeamDlData = TeamDlData();
    visitorTeamDlData = TeamDlData();
    rpcOvers = "";
    rpcTarget = "";
    localTeam = LocalTeam();
    visitorTeam = LocalTeam();
    runs = [];
    venue = Venue();
    links = PageLink();
    meta = MetaData();
    formattedDate = "";
    bowling = [];
    batting = [];
    stage = Stage();
    balls = [];
    league = League();
    showNativeAdd = false;
  }

  Fixture.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'];
    leagueId = json['league_id'] ?? 0;
    seasonId = json['season_id'] ?? 0;
    stageId = json['stage_id'] ?? 0;
    round = json['round'] ?? "";
    localTeamId = json['localteam_id'] ?? 0;
    visitorTeamId = json['visitorteam_id'] ?? 0;
    startingAt = DateTime.parse(json['starting_at'].toString());
    type = json['type'] ?? "";
    live = json['live'] ?? false;
    status = getStatus(json['status']);
    note = json['note'] ?? "";
    venueId = json['venue_id'] ?? 0;
    tossWonTeamId = json['toss_won_team_id'] ?? 0;
    winnerTeamId = json['winner_team_id'] ?? 0;
    drawNoResult = json['draw_noresult'] ?? "";
    firstUmpireId = json['first_umpire_id'] ?? 0;
    secondUmpireId = json['second_umpire_id'] ?? 0;
    tvUmpireId = json['tv_umpire_id'] ?? 0;
    refereeId = json['referee_id'] ?? 0;
    manOfMatchId = json['man_of_match_id'] ?? 0;
    manOfSeriesId = json['man_of_series_id'] ?? 0;
    totalOversPlayed = json['total_overs_played'] ?? 0;
    elected = json['elected'] ?? "";
    superOver = json['super_over'] ?? false;
    followOn = json['follow_on'] ?? false;
    localTeamDlData = json['localteam_dl_data'] != null ? TeamDlData.fromJson(json['localteam_dl_data']) : null;
    visitorTeamDlData = json['visitorteam_dl_data'] != null ? TeamDlData.fromJson(json['visitorteam_dl_data']) : null;
    rpcOvers = json['rpc_overs'] ?? "";
    rpcTarget = json['rpc_target'] ?? "";
    localTeam = json['localteam'] == null ? LocalTeam() : LocalTeam.fromJson(json['localteam']);
    visitorTeam = json['visitorteam'] == null ? LocalTeam() : LocalTeam.fromJson(json['visitorteam']);
    runs = json["runs"] == null ? [] : json["runs"].map<Runs>((obj) => Runs.fromJson(obj)).toList();
    venue = json['venue'] == null ? Venue() : Venue.fromJson(json['venue']);
    formattedDate = _toDate(json['starting_at']);
    time = _toTime(json['starting_at']);
    bowling = json["bowling"] == null ? [] : json["bowling"].map<Bowling>((obj) => Bowling.fromJson(obj)).toList();
    batting = json["batting"] == null ? [] : json["batting"].map<Batting>((obj) => Batting.fromJson(obj)).toList();
    stage = json['stage'] == null ? Stage() : Stage.fromJson(json['stage']);
    balls = json["balls"] == null ? [] : json["balls"].map<Ball>((obj) => Ball.fromJson(obj)).toList();
    league = json['league'] == null ? League() : League.fromJson(json['league']);
    runsLocal = runs.firstWhereOrNull((e) => e.teamId == localTeamId);
    runsVisitor = runs.firstWhereOrNull((e) => e.teamId == visitorTeamId);
    try {
      international = localTeam.nationalTeam || visitorTeam.nationalTeam;
    } catch (ex) {
      international = false;
    }
    showNativeAdd = false;
  }

  String _toDate(dynamic date) {
    if (date == null) {
      return "";
    }
    try {
      return DateFormat("dd MMM yyyy").format(DateTime.parse(date.toString()).toLocal());
    } catch (e) {
      return date;
    }
  }

  String _toTime(dynamic date) {
    if (date == null) {
      return "";
    }
    try {
      final dateTime = DateTime.parse(date.toString()).toLocal();
      final localDate = DateTime.now();
      if (localDate.isAfter(dateTime)) {
        return "";
      }
      return DateFormat("hh:mm aa").format(dateTime);
    } catch (e) {
      return date;
    }
  }

  String getStatus(dynamic data) {
    if (data == null) {
      return "-";
    }
    String status = '-';

    switch (data.toString().toLowerCase()) {
      case "st":
        status = "Statrted";
        break;
      case "ns":
        status = "Not Started";
        break;
      case "aban.":
        status = "Abandoned";
        break;
      case "int.":
        status = "Intrupted";
        break;
      default:
        status = data;
        break;
    }

    return status;
  }
}
