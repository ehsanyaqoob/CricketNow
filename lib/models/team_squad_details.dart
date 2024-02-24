import 'package:cricketapp/models/team_squad.dart';

class TeamSquadDetails {
  late String resource;
  late int id;
  late String name;
  late String code;
  late String imagePath;
  late int countryId;
  late bool nationalTeam;
  late DateTime? updatedAt;
  late List<TeamSquad> squad;

  TeamSquadDetails() {
    resource = "";
    id = 0;
    name = "";
    code = "";
    imagePath = "";
    countryId = 0;
    nationalTeam = false;
    updatedAt = null;
    squad = [];
  }

  TeamSquadDetails.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    code = json['code'] ?? "";
    imagePath = json['image_path'] ?? "";
    countryId = json['country_id'] ?? 0;
    nationalTeam = json['national_team'] ?? false;
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    squad = json["squad"].map<TeamSquad>((e) => TeamSquad.fromJson(e)).toList();
  }
}
