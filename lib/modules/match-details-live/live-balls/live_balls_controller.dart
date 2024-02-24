import 'dart:async';

import 'package:cricketapp/models/Over.dart';
import 'package:cricketapp/models/ball.dart';
import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../utils/ads_helper.dart';

class LiveBallsController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animController;
  late MatchesRepository _matchesRepository;
  Tween<double> tween = Tween(begin: 0.75, end: 1);
  late ScrollController scrolController;

  String errorMessage = "";
  final loading = true.obs;

  BannerAd? bannerAd;
  final bannerLoaded = false.obs;

  int fixtureId = 0;
  Fixture fixture = Fixture();
  Timer? _timer;
  final oversList = <Over>[].obs;
  late AppService appService;

  LiveBallsController() {
    _matchesRepository = MatchesRepository();
    scrolController = ScrollController();
  }

  @override
  void onInit() {
    appService = Get.find<AppService>();
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    fixtureId = Get.arguments as int;
    _loadBanner();
    _getFixtureDetails();
    super.onInit();
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
      fixture = await _matchesRepository.getFixtureById(fixtureId);
      _updateView();
      startTimer();
    } catch (e) {
      errorMessage = "Could not found data!";
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
      fixture = await _matchesRepository.getLiveScores(fixtureId);
      _updateView();
    } catch (e) {
      debugPrint(e.toString());
      _updateView();
    }
  }

  void _updateView() {
    oversList.clear();
    List<Ball> ballsList = [];
    List<Over> overs = [];
    int over = 0;
    for (final ball in fixture.balls) {
      // if (ball.balls == 6 && ball.overs > over) {
      //   ballsList.add(ball);
      //   overs.add(Over(over: ball.overs, balls: ballsList));
      //   ballsList = [];
      // } else {
      //   over = ball.overs;
      //   ballsList.add(ball);
      // }

      if (ball.balls == 1 && ball.overs != over) {
        ballsList = [];
        ballsList.add(ball);
        over = ball.overs;
        overs.add(Over(over: ball.overs, balls: ballsList));
      } else {
        ballsList.add(ball);
      }
    }
    oversList.addAll(overs.reversed);
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
    }
  }

  void refreshIt() {
    _getFixtureDetails();
  }

  @override
  void onClose() {
    animController.dispose();
    _timer?.cancel();
    scrolController.dispose();
    super.onClose();
  }
}
