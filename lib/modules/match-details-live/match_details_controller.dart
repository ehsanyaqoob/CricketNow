import 'dart:async';

import 'package:cricketapp/models/ball.dart';
import 'package:cricketapp/models/batting.dart';
import 'package:cricketapp/models/bowling.dart';
import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/models/runs.dart';
import 'package:cricketapp/models/team_squad.dart';
import 'package:cricketapp/models/team_squad_details.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/ads_helper.dart';

class MatchDetailsController extends GetxController with GetTickerProviderStateMixin {
  late MatchesRepository _matchesRepository;
  late AnimationController animController;
  late TabController tabController;
  final tabLength = 3;
  Tween<double> tween = Tween(begin: 0.75, end: 1);
  late ScrollController scrolController;

  final fixture = Fixture().obs;
  final localBatters = <Batting>[].obs;
  final visitorBatters = <Batting>[].obs;
  final localBowlers = <Bowling>[].obs;
  final visitorBowlers = <Bowling>[].obs;
  final liveBowling = <Bowling>[].obs;
  final liveBatting = <Batting>[].obs;
  final localTeamRuns = Runs().obs;
  final visitorTeamRuns = Runs().obs;

  TeamSquadDetails localTeamSquad = TeamSquadDetails();
  TeamSquadDetails visitorTeamSquad = TeamSquadDetails();
  List<TeamSquad> players = <TeamSquad>[].obs;

  String liveErrorMessage = "";
  String generalErrorMessage = "";
  String squadErrorMessage = "";
  final loading = false.obs;
  final loadingSquad = false.obs;
  final scroeBoardLoading = false.obs;

  List<ButtonSegment<int>> segments = [];
  final segmentSelection = 0.obs;

  BannerAd? bannerAd;
  final bannerLoaded = false.obs;

  MatchDetailsController() {
    _matchesRepository = MatchesRepository();
    scrolController = ScrollController();
  }

  Timer? _timer;
  final balls = <Ball>[].obs;
  bool isLoadingBalls = false;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: tabLength);
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animController.repeat(reverse: true);
    fixture.value.id = Get.arguments as int;
    _getFixtureDetails();
    super.onInit();

    tabController.addListener(() {
      final index = tabController.index;
      if (!tabController.indexIsChanging) {
        if (index == 2 && localTeamSquad.squad.isEmpty) {
          _loadSquads();
        }
      }
    });

    _loadBanner();
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

  Future _getFixtureDetails() async {
    try {
      loading.value = true;
      fixture.value = await _matchesRepository.getFixtureById(fixture.value.id);
      _updateView();
      _getLiveScores();
      startTimer();
    } catch (e) {
      generalErrorMessage = "Could not found data!";
    }
    loading.value = false;
  }

  void startTimer() {
    if (_timer != null && _timer?.isActive == true) {
      _timer?.cancel();
    }
    _timer = null;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _getLiveScores();
    });
  }

  void _getLiveScores() async {
    try {
      if (!isLoadingBalls) {
        isLoadingBalls = true;
        fixture.value = await _matchesRepository.getLiveScores(fixture.value.id);
        _updateView();
      }
    } catch (e) {
      debugPrint(e.toString());
      _updateView();
    }
    isLoadingBalls = false;
  }

  void _updateView() {
    localTeamRuns.value = fixture.value.runs.singleWhere((e) => e.teamId == fixture.value.localTeamId, orElse: () => Runs());
    visitorTeamRuns.value = fixture.value.runs.singleWhere((e) => e.teamId == fixture.value.visitorTeamId, orElse: () => Runs());

    localBatters.value = fixture.value.batting.where((e) => e.teamId == fixture.value.localTeamId).toList();
    localBowlers.value = fixture.value.bowling.where((e) => e.teamId == fixture.value.localTeamId).toList();
    visitorBatters.value = fixture.value.batting.where((e) => e.teamId == fixture.value.visitorTeamId).toList();
    visitorBowlers.value = fixture.value.bowling.where((e) => e.teamId == fixture.value.visitorTeamId).toList();

    if (tabController.index == 0) {
      balls.value = fixture.value.balls;
      if (balls.isNotEmpty) {
        final ball = balls[balls.length - 1];
        final activeBatter = fixture.value.batting
            .where((e) => ball.batsmanOneOnCreezeId == e.batsman.id || ball.batsmanTwoOnCreezeId == e.batsman.id)
            .toList();
        final activeBowler = fixture.value.bowling.where((e) => e.active).toList();
        if (activeBatter.isNotEmpty) {
          liveBatting.clear();
          liveBatting.addAll(activeBatter);
          liveBatting.sort((e1, e2) {
            return e1.active == e2.active ? 0 : 1;
          });
        }
        if (activeBowler.isNotEmpty) {
          liveBowling.clear();
          liveBowling.addAll(activeBowler);
        }
      }
    }
    refresh();
    try {
      if (scrolController.hasClients) {
        scrolController.animateTo(
          scrolController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      {}
    }
  }

  Future<void> _loadSquads() async {
    try {
      loadingSquad.value = true;
      visitorTeamSquad = await _matchesRepository.getSquadByTeamAndSeasonId(fixture.value.visitorTeamId, fixture.value.seasonId);
      localTeamSquad = await _matchesRepository.getSquadByTeamAndSeasonId(fixture.value.localTeamId, fixture.value.seasonId);
      segments.add(
        ButtonSegment(
          value: 0,
          label: Text(
            visitorTeamSquad.name,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 12,
            ),
          ),
        ),
      );
      segments.add(
        ButtonSegment(
          value: 1,
          label: Text(
            localTeamSquad.name,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 12,
            ),
          ),
        ),
      );
      loadPlayers({0});
    } catch (e) {
      squadErrorMessage = "No record found.";
    }
    loadingSquad.value = false;
  }

  void loadPlayers(Set<int> teamIndex) {
    segmentSelection.value = teamIndex.single;
    if (segmentSelection.value == 1) {
      players = localTeamSquad.squad;
    } else {
      players = visitorTeamSquad.squad;
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    animController.dispose();
    scrolController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}
