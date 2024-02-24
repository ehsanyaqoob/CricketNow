import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../../../utils/ads_helper.dart';

class LiveController extends GetxController with GetTickerProviderStateMixin {
  late MatchesRepository _matchesRepository;
  late AnimationController animController;
  Tween<double> tween = Tween(begin: 0.75, end: 1);
  final int tabLength = 3;
  late TabController tabController;

  List<Fixture> liveMatches = [];
  List<Fixture> upComingMatches = [];
  List<Fixture> finishedMatches = [];
  String errorMessage = "";
  final liveLoading = false.obs;
  final upComingLoading = false.obs;
  final finishedLoading = false.obs;
  late AppService appService;

  final loading = false.obs;
  final nativeAdIsLoaded = false.obs;
  NativeAd? nativeAd;

  LiveController() {
    _matchesRepository = MatchesRepository();
  }

  @override
  void onInit() {
    appService = Get.find<AppService>();
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animController.repeat(reverse: true);
    tabController = TabController(vsync: this, length: tabLength);
    super.onInit();
    tabController.addListener(() {
      refreshIt();
    });

    _getLiveMatches();
  }

  void _loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (liveMatches.isNotEmpty) {
            final match = Fixture();
            var obj = liveMatches.where((e) => e.showNativeAdd == true);
            if (obj.isEmpty) {
              match.showNativeAdd = true;
              liveMatches.insert(2, match);
            } else {
              liveMatches.remove(obj);
            }
          }

          if (upComingMatches.isNotEmpty) {
            final match = Fixture();
            var obj = upComingMatches.where((e) => e.showNativeAdd == true);
            if (obj.isEmpty) {
              match.showNativeAdd = true;
              upComingMatches.insert(2, match);
            } else {
              upComingMatches.remove(obj);
            }
          }

          if (finishedMatches.isNotEmpty) {
            final match = Fixture();
            var obj = finishedMatches.where((e) => e.showNativeAdd == true);
            if (obj.isEmpty) {
              match.showNativeAdd = true;
              finishedMatches.insert(2, match);
            } else {
              finishedMatches.remove(obj);
            }
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

  void refreshIt() {
    final index = tabController.index;
    if (index == 0 && liveMatches.isEmpty && !liveLoading.value) {
      _getLiveMatches();
    } else if (index == 1 && upComingMatches.isEmpty && !upComingLoading.value) {
      _getUpcomingMatches();
    } else if (index == 2 && finishedMatches.isEmpty && !finishedLoading.value) {
      _getFinishedMatches();
    }
  }

  Future _getLiveMatches() async {
    try {
      liveLoading.value = true;
      final date = DateTime.now();
      final startdate = date.subtract(const Duration(days: 6));
      final endDate = date.add(const Duration(days: 1));
      final matches = await _matchesRepository.getAllFixtures(
          startDate: DateFormat("yyyy-MM-dd").format(startdate), endDate: DateFormat("yyyy-MM-dd").format(endDate), currentPage: 1);
      matches.sort((e1, e2) {
        final d1 = e1.startingAt;
        final d2 = e2.startingAt;
        if (d1 == null || d2 == null) {
          return -1;
        }
        return d2.compareTo(d1);
      });
      liveMatches = matches.where((e) {
        return e.live &&
            e.localTeam.nationalTeam &&
            (e.status.toLowerCase() == "1st innings" ||
                e.status.toLowerCase() == "2nd innings" ||
                e.status.toLowerCase() == "finished" ||
                e.status.toLowerCase() == "abandoned" ||
                e.status.toLowerCase() == "intrupted");
      }).toList();

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
    liveLoading.value = false;
  }

  Future<void> _getUpcomingMatches() async {
    try {
      upComingLoading.value = true;
      final date = DateTime.now();
      final startDate = date.add(const Duration(days: 1));
      final endDate = startDate.add(const Duration(days: 30));
      final matches = await _matchesRepository.getAllFixtures(
          startDate: DateFormat("yyyy-MM-dd").format(startDate), endDate: DateFormat("yyyy-MM-dd").format(endDate), currentPage: 1);
      matches.sort((e1, e2) {
        final d1 = e1.startingAt;
        final d2 = e2.startingAt;
        if (d1 == null || d2 == null) {
          return -1;
        }
        return d1.compareTo(d2);
      });
      upComingMatches = matches.where((e) {
        return e.status.toLowerCase() != "1st innings" &&
            e.status.toLowerCase() != "2nd innings" &&
            e.status.toLowerCase() != "Abandoned" &&
            e.status.toLowerCase() == "intrupted";
      }).toList();
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
    upComingLoading.value = false;
  }

  Future<void> _getFinishedMatches() async {
    try {
      finishedLoading.value = true;
      final date = DateTime.now();
      final startDate = date.subtract(const Duration(days: 15));
      final matches = await _matchesRepository.getAllFixtures(
          startDate: DateFormat("yyyy-MM-dd").format(startDate), endDate: DateFormat("yyyy-MM-dd").format(date), currentPage: 1);
      matches.sort((e1, e2) {
        final d1 = e1.startingAt;
        final d2 = e2.startingAt;
        if (d1 == null || d2 == null) {
          return -1;
        }
        return d2.compareTo(d1);
      });
      finishedMatches = matches.where((e) {
        return e.runs.isNotEmpty;
      }).toList();
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
    finishedLoading.value = false;
  }

  bool canShowDate(int index, int pageIndex) {
    if (index == 0) {
      return true;
    }

    DateTime? d1;
    DateTime? d2;

    if (pageIndex == 0) {
      d1 = index < liveMatches.length ? liveMatches[index - 1].startingAt : null;
      d2 = index < liveMatches.length ? liveMatches[index].startingAt : null;
    } else if (pageIndex == 1) {
      d1 = index < upComingMatches.length ? upComingMatches[index - 1].startingAt : null;
      d2 = index < upComingMatches.length ? upComingMatches[index].startingAt : null;
    } else if (pageIndex == 2) {
      d1 = index < finishedMatches.length ? finishedMatches[index - 1].startingAt : null;
      d2 = index < finishedMatches.length ? finishedMatches[index].startingAt : null;
    }

    return !DateUtils.isSameDay(d1, d2);
  }

  @override
  void onClose() async {
    super.onClose();
    animController.dispose();
    await nativeAd?.dispose();
  }
}
