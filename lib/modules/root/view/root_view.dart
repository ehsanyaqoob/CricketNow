import 'package:cricketapp/modules/root/controller/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          children: [
            Expanded(child: controller.currentPage),
            controller.bannerLoaded.value
                ? SafeArea(
                    child: Container(
                      margin: const EdgeInsets.only(top: 12.0, bottom: 10.0, left: 0.0, right: 0.0),
                      color: Colors.transparent,
                      width: controller.bannerAd!.size.width.toDouble(),
                      height: controller.bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: controller.bannerAd!),
                    ),
                  )
                : const SizedBox(
                    width: 1,
                  ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 5, offset: const Offset(0, 1)),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              currentIndex: controller.currentIndex.value,
              onTap: (index) => {controller.changePageInRoot(index)},
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 20,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.schedule_outlined,
                    size: 20,
                  ),
                  label: "Series",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.live_tv,
                    size: 20,
                  ),
                  label: "Live",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.newspaper_outlined,
                    size: 20,
                  ),
                  label: "News",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.more_outlined,
                    size: 20,
                  ),
                  label: "More",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
