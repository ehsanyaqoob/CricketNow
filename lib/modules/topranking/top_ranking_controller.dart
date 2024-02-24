import 'dart:collection';

import 'package:cricketapp/models/local_team.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/ads_helper.dart';

class TopRankingController extends GetxController with GetTickerProviderStateMixin {
  late MatchesRepository _matchesRepository;
  late AnimationController animController;
  late TabController tabController;
  FirebaseDatabase firebase = FirebaseDatabase.instance;
  BannerAd? bannerAd;
  final bannerLoaded = false.obs;

  Tween<double> tween = Tween(begin: 0.75, end: 1);

  String errorMessage = "";
  final loading = true.obs;

  String title = "";
  int id = 0;
  List<LocalTeam> mList = [];
  Map<String, List<LocalTeam>> tabs = HashMap<String, List<LocalTeam>>();
  late AppService appService;

  TopRankingController() {
    _matchesRepository = MatchesRepository();
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

  @override
  void onInit() {
    appService = Get.find<AppService>();
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    final arg = Get.arguments;
    id = arg["id"];
    title = arg["title"];
    if (id == 1) {
      _getInternationalTeams();
    }
    _loadBanner();
    super.onInit();
  }

  Future<void> _getInternationalTeams() async {
    loading.value = true;
    try {
      final teamRankings = await _matchesRepository.getTeamsWithRanking();
      for (final rank in teamRankings) {
        if (!tabs.containsKey(rank.type)) {
          //mList.addAll(rank.teams);
          tabs[rank.type] = rank.teams;
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    tabController = TabController(vsync: this, length: tabs.length);
    loading.value = false;
  }

  void refreshIt() {
    _getInternationalTeams();
  }

  @override
  void onClose() {
    animController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
