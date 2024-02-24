class Player {
  late String id;
  late String name;
  late String role;
  late String battingStyle;
  late String country;
  late String playerImg;
  late List<String> altnames;

  Player() {
    id = "";
    name = "";
    role = "";
    battingStyle = "";
    country = "";
    playerImg = "";
    altnames = [];
  }

  Player.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    name = json["name"] ?? "";
    role = json["role"] ?? "";
    battingStyle = json["battingStyle"] ?? "";
    country = json["country"] ?? "";
    playerImg = json["playerImg"] ?? "";
    altnames = json["altnames"] ?? [];
  }
}
