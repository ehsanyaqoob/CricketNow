import 'package:cricketapp/models/meta_link.dart';

class MetaData {
  late int currentPage;
  late int from;
  late int lastPage;
  late List<MetaLink> links;
  late String path;
  late int perPage;
  late int to;
  late int total;

  MetaData() {
    currentPage = 0;
    from = 0;
    lastPage = 0;
    links = [];
    path = "";
    perPage = 0;
    to = 0;
    total = 0;
  }

  MetaData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    links = json["links"] == null ? [] : json["links"].map<MetaLink>((obj) => MetaLink.fromJson(obj)).toList();
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}
