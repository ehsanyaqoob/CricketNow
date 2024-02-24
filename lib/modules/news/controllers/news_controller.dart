import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricketapp/models/blog.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:cricketapp/utils/ads_helper.dart';
import 'package:cricketapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewsController extends GetxController with GetSingleTickerProviderStateMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late AnimationController animController;

  final nativeAdIsLoaded = false.obs;
  NativeAd? nativeAd;

  List<Blog> blogsList = [];
  final loading = false.obs;
  final errorMessage = "";
  late AppService appService;

  @override
  void onInit() {
    animController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    animController.repeat(reverse: true);
    super.onInit();
    _getBlogsList();
  }

  void _getBlogsList() async {
    appService = Get.find<AppService>();
    loading.value = true;
    _db.collection(Constants.TABLE_BLOGS).get().then((querySnapshot) {
      final docs = querySnapshot.docs;
      blogsList = docs.map<Blog>((e) => Blog.fromJson(e.data())).toList();

      if (nativeAd != null) {
        nativeAd?.dispose();
        nativeAd == null;
      }
      loading.value = false;
      _loadNativeAd();
    }).catchError((error) {
      debugPrint(error.toString());
      loading.value = false;
    });
  }

  void refreshIt() {
    _getBlogsList();
  }

  void _loadNativeAd() {
    nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (blogsList.isNotEmpty) {
            final blog = Blog();
            blog.showAdd = true;
            blogsList.insert(1, blog);
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

  @override
  void onClose() async {
    await nativeAd?.dispose();
    super.onClose();
  }
}
