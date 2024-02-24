import 'dart:async';

import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/models/local_team.dart';
import 'package:cricketapp/models/series_stat.dart';
import 'package:cricketapp/models/standing.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../utils/ads_helper.dart';

class SeriesInfoController extends GetxController with GetTickerProviderStateMixin {
  late MatchesRepository _matchesRepository;
  late AnimationController animController;
  late TabController tabController;
  Tween<double> tween = Tween(begin: 0.75, end: 1);
  final tabLength = 4;

  List<Fixture> fixturesList = [];
  String errorMessage = "";
  final loading = false.obs;
  final squadLoading = false.obs;
  final pointsLoading = false.obs;
  final statsLoading = false.obs;
  String squadErrorMessage = "";
  String pointsErrorMessage = "";
  String statsErrorMessage = "";
  final title = "".obs;
  final type = "".obs;
  int leagueId = 0, stageId = 0, seasonId = 0;
  List<LocalTeam> teamsList = [];
  List<Standing> pointsList = [];
  int favouriteTeamId = 0;
  int currentIndex = 0;
  List<SeriesStat> seriesStats = [];
  late AppService appService;
  final nativeAdIsLoaded = false.obs;
  NativeAd? nativeAd;

  BannerAd? bannerAd;
  final bannerLoaded = false.obs;

  SeriesInfoController() {
    _matchesRepository = MatchesRepository();
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    tabController = TabController(vsync: this, length: tabLength);
    animController.repeat(reverse: true);
  }

  @override
  void onInit() {
    appService = Get.find<AppService>();
    final arg = Get.arguments;
    currentIndex = arg["index"];
    leagueId = arg["league_id"];
    stageId = arg["stage_id"];
    seasonId = arg["season_id"];
    favouriteTeamId = Get.find<AppService>().favouriteTeamId.value;
    super.onInit();
    _loadBanner();
    _getStageInfo();
    tabController.addListener(() {
      final index = tabController.index;
      if (!tabController.indexIsChanging) {
        if (index == 0 && fixturesList.isEmpty && !loading.value) {
          _getStageInfo();
        } else if (index == 1 && teamsList.isEmpty && !squadLoading.value) {
          _getSquads();
        } else if (index == 2) {
          if (leagueId != 0 && pointsList.isEmpty && !pointsLoading.value) {
            _getPoints();
          } else if (stageId != 0 && seriesStats.isEmpty && !statsLoading.value) {
            _loadStats();
          }
        }
      }
    });
  }

  void _loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (fixturesList.isNotEmpty) {
            final match = Fixture();
            match.showNativeAdd = true;
            fixturesList.insert(1, match);
          }
          nativeAdIsLoaded.value = true;
          loading.refresh();
        },
        onAdFailedToLoad: (ad, error) {
          nativeAdIsLoaded.value = false;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
      // Styling
      nativeTemplateStyle: NativeTemplateStyle(
        // Required: Choose a template.
        templateType: TemplateType.medium,
        // Optional: Customize the ad's style.

        cornerRadius: 20.0,
        callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Colors.white, backgroundColor: const Color(0xFF39374C), style: NativeTemplateFontStyle.monospace, size: 16.0),
        primaryTextStyle:
            NativeTemplateTextStyle(textColor: Colors.red, backgroundColor: Colors.cyan, style: NativeTemplateFontStyle.italic, size: 16.0),
        secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.green, backgroundColor: Colors.black, style: NativeTemplateFontStyle.bold, size: 16.0),
        tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.brown, backgroundColor: Colors.white, style: NativeTemplateFontStyle.normal, size: 16.0),
      ),
    )..load();
  }

  void _loadBanner() {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.fullBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          bannerLoaded.value = true;
        },
        onAdFailedToLoad: (ad, err) {
          bannerAd = null;
          bannerLoaded.value = false;
          ad.dispose();
        },
      ),
    ).load();
  }

  Future _getStageInfo() async {
    try {
      loading.value = true;

      final date = DateTime.now();
      final startDate = date.subtract(const Duration(days: 15));
      final endDate = date.add(const Duration(days: 30));

      final fixtures = await _matchesRepository.getAllFixtures(
          startDate: DateFormat("yyyy-MM-dd").format(startDate), endDate: DateFormat("yyyy-MM-dd").format(endDate), currentPage: 0);

      if (leagueId != 0) {
        final league = await _matchesRepository.getLeagueById(leagueId);
        title.value = league.name;
        fixturesList = fixtures.where((element) => element.leagueId == leagueId).toList();

        // fixturesList = await _matchesRepository.getFixturesBy(
        //     filter: "league_id", id: leagueId);
      } else if (stageId != 0) {
        final stage = await _matchesRepository.getStageById(stageId);
        title.value = stage.name;
        fixturesList = fixtures.where((element) => element.stageId == stageId).toList();

        // fixturesList = await _matchesRepository.getFixturesBy(
        //     filter: "stage_id", id: stageId);
      }
      if (fixturesList.isNotEmpty) {
        type.value = fixturesList[0].type;
      }
      fixturesList.sort((e1, e2) {
        final d1 = e1.startingAt;
        final d2 = e2.startingAt;
        if (d1 == null || d2 == null) {
          return -1;
        }
        return d2.compareTo(d1);
      });
      if (currentIndex != 0) {
        tabController.animateTo(currentIndex, duration: const Duration(microseconds: 800));
      }
      if (nativeAd != null) {
        nativeAd?.dispose();
        nativeAd == null;
      }
      loading.value = false;
      _loadNativeAd();
    } catch (e) {
      errorMessage = "Could not found data!";
      loading.value = false;
    }
    loading.value = false;
  }

  Future _getSquads() async {
    try {
      squadLoading.value = true;
      if (teamsList.isEmpty) {
        _createSquadList();
      }
    } catch (e) {
      squadErrorMessage = "Could not found data!";
    }
    squadLoading.value = false;
  }

  Future _getPoints() async {
    try {
      pointsLoading.value = true;
      pointsList = await _matchesRepository.getStandings(seasonId);
      if (teamsList.isEmpty) {
        _createSquadList();
      }
      for (var element in pointsList) {
        final team = teamsList.singleWhere((e) => e.id == element.teamId, orElse: () => LocalTeam());
        if (team.id != 0) element.team = team;
      }
    } catch (e) {
      pointsErrorMessage = "Could not found data!";
    }
    if (pointsList.isEmpty) {
      pointsErrorMessage = "No record found.";
    }
    pointsLoading.value = false;
  }

  void _createSquadList() {
    for (var e in fixturesList) {
      final localTeam = teamsList.where((element) => element.id == e.localTeamId);
      if (localTeam.isEmpty) {
        teamsList.add(e.localTeam);
      }
      final visitorTeam = teamsList.where((element) => element.id == e.visitorTeamId);
      if (visitorTeam.isEmpty) {
        teamsList.add(e.visitorTeam);
      }
    }
  }

  void _loadStats() {
    statsLoading.value = true;
    for (final fixture in fixturesList) {
      SeriesStat? stat =
          seriesStats.firstWhereOrNull((e) => e.localTeam.id == fixture.localTeamId && e.visitorTeam.id == fixture.visitorTeamId);
      if (stat == null) {
        stat = SeriesStat();
        stat.localTeam = fixture.localTeam;
        stat.visitorTeam = fixture.visitorTeam;
        seriesStats.add(stat);
      }
      final runLocal = fixture.runs.firstWhereOrNull((e) => e.teamId == stat?.localTeam.id);
      final runVisitor = fixture.runs.firstWhereOrNull((e) => e.teamId == stat?.visitorTeam.id);
      int scoreLocal = 0, scoreVisitor = 0;
      if (runLocal != null) {
        scoreLocal = runLocal.score;
      }

      if (runVisitor != null) {
        scoreVisitor = runVisitor.score;
      }

      if (scoreLocal > scoreVisitor) {
        stat.wonMatchLocal += 1;
      } else if (scoreVisitor > 0) {
        stat.wonMatchVisitor += 1;
      }

      if (fixture.runs.isNotEmpty) {
        stat.played += 1;
      }
      stat.total += 1;
    }
    statsLoading.value = false;
  }

  void refreshStageInfo() {
    _getStageInfo();
  }

  bool canShowDate(int index) {
    if (index == 0) {
      return true;
    }
    final d1 = index < fixturesList.length ? fixturesList[index - 1].formattedDate : null;
    final d2 = index < fixturesList.length ? fixturesList[index].formattedDate : null;
    return d1 != d2;
  }

  void navigateToTeamDetails(int index) {
    List<int> ids = [];
    ids.add(teamsList[index].id);
    ids.add(seasonId);
    Get.toNamed(Routes.SQUAD_INFO, arguments: ids);
  }

  @override
  void onClose() async {
    animController.dispose();
    tabController.dispose();
    await nativeAd?.dispose();
    super.onClose();
  }
}
