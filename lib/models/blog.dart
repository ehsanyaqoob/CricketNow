import 'package:intl/intl.dart';

class Blog {
  late String id;
  late String title;
  late String details;
  late String imageUrl;
  late DateTime? createdAt;
  late String dateQuery;
  late bool status;
  late String formattedDate;
  late bool showAdd;

  Blog() {
    id = "";
    title = "";
    details = "";
    imageUrl = "";
    createdAt = null;
    dateQuery = "";
    status = false;
    formattedDate = "";
    showAdd = false;
  }

  Blog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'].toDate();
    dateQuery = json['dateQuery'];
    status = json['status'];
    formattedDate = _toDate(json['createdAt'].toDate());
    showAdd = false;
  }

  String _toDate(dynamic date) {
    if (date == null) {
      return "";
    }
    try {
      return DateFormat("dd MMM yyyy").format(DateTime.parse(date.toString()));
    } catch (e) {
      return date;
    }
  }
}
