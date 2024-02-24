import 'package:cricketapp/models/team_position.dart';

class TeamSquad {
  late String resource;
  late int id;
  late int countryId;
  late String firstname;
  late String lastname;
  late String fullName;
  late String imagePath;
  late DateTime? dateOfBirth;
  late String gender;
  late String battingStyle;
  late String bowlingStyle;
  late TeamPosition position;
  late DateTime? updatedAt;

  TeamSquad() {
    resource = "";
    id = 0;
    countryId = 0;
    firstname = "";
    lastname = "";
    fullName = "";
    imagePath = "";
    dateOfBirth = null;
    gender = "";
    battingStyle = "";
    bowlingStyle = "";
    position = TeamPosition();
    updatedAt = null;
  }

  TeamSquad.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    countryId = json['country_id'] ?? 0;
    firstname = json['firstname'] ?? "";
    lastname = json['lastname'] ?? "";
    fullName = json['fullname'] ?? "";
    imagePath = json['image_path'] ?? "";
    dateOfBirth = json['dateofbirth'] != null ? DateTime.parse(json['dateofbirth']) : null;
    gender = json['gender'] ?? "";
    battingStyle = formatBattingStyle(json['battingstyle']);
    bowlingStyle = formatBattingStyle(json['bowlingstyle']);
    position = TeamPosition.fromJson(json['position']);
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
  }

  String formatBattingStyle(dynamic data) {
    if (data == null) {
      return "";
    }
    try {
      return data.toString().trim().split("-").map((e) => e[0]).join();
    } catch (ex) {
      return "";
    }
  }
}
