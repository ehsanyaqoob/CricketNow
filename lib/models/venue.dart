class Venue {
  late String resource;
  late int id;
  late int countryId;
  late String name;
  late String city;
  late String imagePath;
  late int capacity;
  late bool floodlight;
  late DateTime? updatedAt;

  Venue() {
    resource = "";
    id = 0;
    countryId = 0;
    name = "";
    city = "";
    imagePath = "";
    capacity = 0;
    floodlight = false;
    updatedAt = null;
  }

  Venue.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    countryId = json['country_id'] ?? 0;
    name = json['name'] ?? "";
    city = json['city'] ?? "";
    imagePath = json['image_path'] ?? "";
    capacity = json['capacity'] ?? 0;
    floodlight = json['floodlight'] ?? false;
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at'].toString()) : null;
  }
}
