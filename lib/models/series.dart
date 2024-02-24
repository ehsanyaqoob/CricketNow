import 'package:intl/intl.dart';

class Series {
  late String id;
  late String name;
  late String startDate;
  late String endDate;
  late int odi;
  late int t20;
  late int test;
  late int squads;

  Series() {
    id = "";
    name = "";
    startDate = "";
    endDate = "";
    odi = 0;
    t20 = 0;
    test = 0;
    squads = 0;
  }

  Series.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    name = json["name"] ?? "";
    startDate = _getDate(json["startDate"]);
    endDate = _getDate(json["endDate"]);
    odi = json["odi"] ?? "";
    t20 = json["t20"] ?? "";
    test = json["test"];
    squads = json["squads"];
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
