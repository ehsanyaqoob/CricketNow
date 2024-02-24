class League {
  late String resource;
  late int id;
  late int seasonId;
  late int countryId;
  late String name;
  late String code;
  late String imagePath;
  late String type;
  late DateTime? updatedAt;
  late bool showNativeAdd;

  League() {
    resource = "";
    id = 0;
    seasonId = 0;
    countryId = 0;
    name = "";
    code = "";
    imagePath = "";
    type = "";
    updatedAt = null;
    showNativeAdd = false;
  }

  League.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    seasonId = json['season_id'] ?? 0;
    countryId = json['country_id'] ?? 0;
    name = json['name'] ?? "";
    code = json['code'] ?? "";
    imagePath = json['image_path'] ?? "";
    type = json['type'] ?? "";
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at'].toString()) : null;
    showNativeAdd = false;
  }
}
