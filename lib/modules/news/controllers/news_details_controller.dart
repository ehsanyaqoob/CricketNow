import 'package:cricketapp/models/blog.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../utils/ads_helper.dart';

class NewsDetailsController extends GetxController {
  Blog blog = Blog();

  BannerAd? bannerAd;
  final bannerLoaded = false.obs;

  @override
  void onInit() {
    blog = Get.arguments as Blog;
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
}
