class PageLink {
  late String first;
  late String last;
  late String prev;
  late String next;

  PageLink() {
    first = "";
    last = "";
    prev = "";
    next = "";
  }

  PageLink.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }
}
