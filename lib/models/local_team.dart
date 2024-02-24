import 'package:cricketapp/models/ranking.dart';

class LocalTeam {
  late String resource;
  late int id;
  late String name;
  late String code;
  late String imagePath;
  late int countryId;
  late bool nationalTeam;
  late Ranking ranking;

  LocalTeam() {
    resource = "";
    id = 0;
    name = "";
    code = "";
    imagePath = "";
    countryId = 0;
    nationalTeam = false;
    ranking = Ranking();
  }

  LocalTeam.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
    code = json['code'] ?? "";
    imagePath = json['image_path'] ?? "";
    countryId = json['country_id'] ?? 0;
    nationalTeam = json['national_team'] ?? false;
    ranking = json['ranking'] == null ? Ranking() : Ranking.fromJson(json['ranking']);
  }
}
