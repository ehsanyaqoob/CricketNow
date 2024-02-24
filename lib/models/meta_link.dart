class MetaLink {
  late String url;
  late String label;
  late bool active;

  MetaLink() {
    url = "";
    label = "";
    active = false;
  }

  MetaLink.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }
}
