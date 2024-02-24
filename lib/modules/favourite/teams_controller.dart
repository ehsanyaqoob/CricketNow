import 'package:cricketapp/models/local_team.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/ads_helper.dart';

class TeamsController extends GetxController with GetSingleTickerProviderStateMixin {
  late MatchesRepository _matchesRepository;
  final loading = false.obs;
  List<LocalTeam> teamsList = [];
  String errorMessage = "";
  late AppService appService;
  final selectedItem = 0.obs;

  BannerAd? bannerAd;
  final bannerLoaded = false.obs;

  late AnimationController animController;
  Tween<double> tween = Tween(begin: 0.75, end: 1);

  TeamsController() {
    _matchesRepository = MatchesRepository();
  }

  @override
  void onInit() {
    appService = Get.find<AppService>();
    selectedItem.value = appService.favouriteTeamId.value;
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animController.repeat(reverse: true);
    _getTeamsList();
    _loadBanner();
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

  Future<void> _getTeamsList() async {
    loading.value = true;
    try {
      final list = await _matchesRepository.getAllTeams();
      teamsList.addAll(list.where((e) => e.nationalTeam).toList());
    } catch (e) {
      errorMessage = "There is problem. No record found.";
    }
    if (teamsList.isEmpty && errorMessage.isEmpty) {
      errorMessage = "No record found.";
    }
    loading.value = false;
  }

  void onClickItem(int id) {
    selectedItem.value = id == selectedItem.value ? 0 : id;
  }

  void onClickContinue() {
    if (selectedItem.value > 0) {
      appService.favouriteTeamId.value = selectedItem.value;
    }
    appService.showFavourite.value = false;
    Get.offAllNamed(AppPages.initialRoute);
  }

  void refreshIt() {
    _getTeamsList();
  }

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }
}
