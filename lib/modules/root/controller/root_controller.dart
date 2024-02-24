import 'package:cricketapp/modules/home/views/home_view.dart';
import 'package:cricketapp/modules/live/views/live_view.dart';
import 'package:cricketapp/modules/more/views/more_view.dart';
import 'package:cricketapp/modules/news/views/news_view.dart';
import 'package:cricketapp/modules/series/views/series_view.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/utils/ads_helper.dart';
import 'package:cricketapp/utils/app_life_cycler_observer.dart';
import 'package:cricketapp/utils/open_app_ad_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RootController extends GetxController with WidgetsBindingObserver {
  final currentIndex = 0.obs;

  List<Widget> pages = [
    const HomeView(),
    const SeriesView(),
    const LiveView(),
    const NewsView(),
    const MoreView(),
  ];

  BannerAd? bannerAd;
  final bannerLoaded = false.obs;

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is int) {
      changePageInRoot(Get.arguments as int);
    } else {
      changePageInRoot(0);
    }
    super.onInit();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    AppLifecycleObserver(appOpenAdManager: appOpenAdManager).listenToAppStateChanges();
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

  Widget get currentPage => pages[currentIndex.value];

  void changePageInRoot(int index) {
    currentIndex.value = index;
  }

  void changePageOutRoot(int index) {
    currentIndex.value = index;
    Get.offNamedUntil(Routes.ROOT, (Route route) {
      if (route.settings.name == Routes.ROOT) {
        return true;
      }
      return false;
    }, arguments: index);
  }

  void changePage(int index) {
    if (Get.currentRoute == Routes.ROOT) {
      changePageInRoot(index);
    } else {
      changePageOutRoot(index);
    }
  }
}
