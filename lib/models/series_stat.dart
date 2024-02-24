import 'package:cricketapp/models/local_team.dart';

class SeriesStat {
  late String title;
  late LocalTeam localTeam;
  late LocalTeam visitorTeam;
  late int played;
  late int total;
  late int wonMatchLocal;
  late int wonMatchVisitor;

  SeriesStat() {
    title = "";
    localTeam = LocalTeam();
    visitorTeam = LocalTeam();
    played = 0;
    total = 0;
    wonMatchLocal = 0;
    wonMatchVisitor = 0;
  }
}
