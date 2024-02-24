class TeamPosition {
  late String resource;
  late int id;
  late String name;

  TeamPosition() {
    resource = "";
    id = 0;
    name = "";
  }

  TeamPosition.fromJson(Map<String, dynamic> json) {
    resource = json['resource'] ?? "";
    id = json['id'] ?? 0;
    name = json['name'] ?? "";
  }
}
