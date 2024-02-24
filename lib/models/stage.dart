import 'package:cricketapp/models/fixture.dart';
import 'package:intl/intl.dart';

class Stage {
  late String resource;
  late int id;
  late int leagueId;
  late int seasonId;
  late String name;
  late String code;
  late String type;
  late bool standings;
  late DateTime? updatedAt;
  late String formattedDate;
  late List<Fixture> fixtures;
  late bool showNativeAdd;

  Stage() {
    resource = "";
    id = 0;
    leagueId = 0;
    seasonId = 0;
    name = "";
    code = "";
    type = "";
    standings = false;
    updatedAt = null;
    fixtures = [];
    showNativeAdd = false;
  }

  Stage.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    leagueId = json['league_id'] ?? 0;
    seasonId = json['season_id'] ?? 0;
    name = json['name'] ?? "";
    code = json['code'] ?? "";
    type = json['type'] ?? "";
    standings = json['standings'] ?? false;
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    formattedDate = _getDate(json['updated_at']);
    fixtures = json["fixtures"] != null ? json["fixtures"].map<Fixture>((e) => Fixture.fromJson(e)).toList() : [];
    showNativeAdd = false;
  }

  String _getDate(dynamic date) {
    if (date == null) {
      return "";
    }
    try {
      return DateFormat("dd MMM yyyy").format(DateTime.parse(date.toString()));
    } catch (e) {
      return date;
    }
  }
}
