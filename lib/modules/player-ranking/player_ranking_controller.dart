import 'dart:collection';

import 'package:cricketapp/models/player_ranking.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/ads_helper.dart';

class PlayerRankingController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animController;
  TabController? tabController;
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  Tween<double> tween = Tween(begin: 0.75, end: 1);

  String errorMessage = "";
  final loading = true.obs;

  String title = "";
  int id = 0;
  List<PlayerRanking> mList = [];
  Map<String, List<PlayerRanking>> tabs =
      HashMap<String, List<PlayerRanking>>();
  String key = "";
  late AppService appService;

  BannerAd? bannerAd;
  final bannerLoaded = false.obs;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    animController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    final arg = Get.arguments;
    id = arg["id"];
    title = arg["title"];
    switch (id) {
      case 1:
        key = "teams";
        break;
      case 2:
        key = "allrounders";
        break;
      case 3:
        key = "batters";
        break;
      case 4:
        key = "bowlers";
        break;
    }
    _loadBanner();
    _getData();
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

  void _getData() {
    loading.value = true;
    _db.child(key).get().then((snapShot) {
      try {
        for (DataSnapshot parent in snapShot.children) {
          String? key = parent.key;
          if (key != null) {
            List<PlayerRanking> list = [];
            final dataList = parent.value as List;
            for (final data in dataList) {
              PlayerRanking ranking = PlayerRanking();
              ranking.rank = data["rank"];
              ranking.rating = data["rating"];
              ranking.player = data["player"];
              ranking.team = data["team"];
              ranking.teamUrl = Utils.getCountryFlag(data["team"]);
              list.add(ranking);
            }
            tabs[key.toUpperCase()] = list;
          }
        }
        tabController = TabController(vsync: this, length: tabs.length);
        loading.value = false;
      } catch (e) {
        errorMessage = e.toString();
        loading.value = false;
      }
    }).onError((error, stackTrace) {
      errorMessage = error.toString();
      loading.value = false;
    });
  }

  void refreshIt() {
    _getData();
  }

  @override
  void onClose() {
    animController.dispose();
    tabController?.dispose();
    super.onClose();
  }
}
