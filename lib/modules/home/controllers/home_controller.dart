import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../../utils/ads_helper.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late MatchesRepository _matchesRepository;
  late AnimationController animController;
  final Tween<double> tween = Tween(begin: 0.75, end: 1);
  final pageIndex = 0.obs;

  final nativeAdIsLoaded = false.obs;
  NativeAd? nativeAd;

  List<Fixture> fixtures = [];
  String errorMessage = "Loading...";
  final loading = false.obs;
  late AppService appService;

  HomeController() {
    _matchesRepository = MatchesRepository();
  }

  @override
  void onInit() {
    appService = Get.find<AppService>();
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animController.repeat(reverse: true);
    super.onInit();
    _getAllMatches();
  }

  Future _getAllMatches() async {
    try {
      loading.value = true;
      final date = DateTime.now();
      final startdate = date.subtract(const Duration(days: 6));
      final endDate = date.add(const Duration(days: 6));
      final list = await _matchesRepository.getAllFixtures(
          startDate: DateFormat("yyyy-MM-dd").format(startdate), endDate: DateFormat("yyyy-MM-dd").format(endDate), currentPage: 1);
      fixtures = list.where((e) {
        return e.status.toLowerCase() == "not started" ||
            e.status.toLowerCase() == "1st innings" ||
            e.status.toLowerCase() == "2nd innings" ||
            e.status.toLowerCase() == "finished" ||
            e.status.toLowerCase() == "abandoned" ||
            e.status.toLowerCase() == "intrupted";
      }).toList();

      fixtures.sort((e1, e2) {
        final d1 = e1.startingAt;
        final d2 = e2.startingAt;
        if (d1 == null || d2 == null) {
          return 0;
        }
        return (e1.status.toLowerCase() == "1st innings" ||
                    e1.status.toLowerCase() == "2nd innings" ||
                    e1.status.toLowerCase() == "not started" ||
                    e1.status.toLowerCase() == "abondoned" ||
                    e1.status.toLowerCase() == "intrupted" ||
                    e1.status.toLowerCase() == "finished") &&
                e1.localTeam.nationalTeam &&
                e1.visitorTeam.nationalTeam
            ? -1
            : d1.compareTo(d2);
      });
      Fixture? fixture = fixtures.firstWhereOrNull(
          (e) => e.localTeamId == appService.favouriteTeamId.value || e.visitorTeamId == appService.favouriteTeamId.value);
      if (fixture != null) {
        fixtures.remove(fixture);
        fixtures.insert(0, fixture);
      }
    } catch (e) {
      errorMessage = "Could not found data!";
      debugPrint(e.toString());
    }

    if (nativeAd != null) {
      nativeAd?.dispose();
      nativeAd == null;
    }
    loading.value = false;
    _loadNativeAd();
  }

  void refreshIt() {
    _getAllMatches();
  }

  void _loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (fixtures.isNotEmpty) {
            final fixture = Fixture();
            fixture.showNativeAdd = true;
            fixtures.insert(4, fixture);
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
        templateType: TemplateType.small,
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

  @override
  void onClose() async {
    await nativeAd?.dispose();
    animController.dispose();
    super.onClose();
  }
}
