class TeamInfo {
  late int id;
  late String name;
  late String shortname;
  late String img;
  late String defImage;

  TeamInfo() {
    id = 0;
    name = "";
    shortname = "";
    img = "";
    defImage = "assets/images/placeholder.png";
  }

  TeamInfo.fromJson(Map<String, dynamic> json) {
    id = 0;
    name = json["name"] ?? "";
    shortname = json["shortname"] ?? "";
    img = json["img"] ?? "";
  }

  String _toLocalImage(dynamic img) {
    if (img == null) return "assets/images/placeholder.png";
    final value = img.toString().toLowerCase();
    if (value.contains("pak")) {
      return "assets/images/pak.png";
    } else if (value.contains("uae")) {
      return "assets/images/uae.png";
    } else if (value.contains("afg")) {
      return "assets/images/afg.png";
    } else if (value.contains("aus")) {
      return "assets/images/aus.png";
    } else if (value.contains("ban")) {
      return "assets/images/ban.png";
    } else if (value.contains("ind")) {
      return "assets/images/ind.png";
    } else if (value.contains("ire")) {
      return "assets/images/ire.png";
    } else if (value.contains("nam")) {
      return "assets/images/nam.png";
    } else if (value.contains("nep")) {
      return "assets/images/nep.png";
    } else if (value.contains("net")) {
      return "assets/images/net.png";
    } else if (value.contains("new")) {
      return "assets/images/new.png";
    } else if (value.contains("oma")) {
      return "assets/images/oma.png";
    } else if (value.contains("sco")) {
      return "assets/images/sco.png";
    } else if (value.contains("sou")) {
      return "assets/images/sou.png";
    } else if (value.contains("sri")) {
      return "assets/images/sri.png";
    } else if (value.contains("wes")) {
      return "assets/images/wes.png";
    } else if (value.contains("zim")) {
      return "assets/images/zim.png";
    } else {
      return "assets/images/placeholder.png";
    }
  }
}
