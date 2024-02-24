import 'package:cricketapp/models/league.dart';
import 'package:cricketapp/models/stage.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SeriesController extends GetxController with GetSingleTickerProviderStateMixin {
  late MatchesRepository _matchesRepository;
  late AnimationController animController;
  Tween<double> tween = Tween(begin: 0.75, end: 1);
  final seriesName = "All Series".obs;

  List<League> leagues = [];
  List<Stage> stages = [];
  String errorMessage = "";
  final loading = false.obs;
  late AppService appService;

  SeriesController() {
    _matchesRepository = MatchesRepository();
  }

  @override
  void onInit() {
    appService = Get.find<AppService>();
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animController.repeat(reverse: true);
    super.onInit();
    _getAllSeries();
  }

  Future<void> _getAllSeries() async {
    try {
      loading.value = true;
      //leagues = await _matchesRepository.getAllLeagues();
      //stages = await _matchesRepository.getAllStages();

      final date = DateTime.now();
      final startDate = date.subtract(const Duration(days: 15));
      final endDate = date.add(const Duration(days: 30));
      Map<String, League> mapLeague = {};

      final fixturesByLeague = await _matchesRepository.getFixturesWithLeague(
          startDate: DateFormat("yyyy-MM-dd").format(startDate), endDate: DateFormat("yyyy-MM-dd").format(endDate));
      for (final fixture in fixturesByLeague) {
        if (!mapLeague.containsKey(fixture.league.name)) {
          mapLeague[fixture.league.name] = fixture.league;
          leagues.add(fixture.league);
        }
      }

      Map<String, Stage> mapStage = {};
      final fixtures = await _matchesRepository.getFixturesWithStage(
          startDate: DateFormat("yyyy-MM-dd").format(startDate), endDate: DateFormat("yyyy-MM-dd").format(endDate));
      for (final fixture in fixtures) {
        if (!mapStage.containsKey(fixture.stage.name)) {
          mapStage[fixture.stage.name] = fixture.stage;
          stages.add(fixture.stage);
        }
      }
      if (leagues.isEmpty) errorMessage = "No record found.";
    } catch (e) {
      errorMessage = "Could not find data.";
    }
    loading.value = false;
  }

  void refreshIt() {
    _getAllSeries();
  }

  @override
  void onClose() {
    super.onClose();
    animController.dispose();
  }
}
