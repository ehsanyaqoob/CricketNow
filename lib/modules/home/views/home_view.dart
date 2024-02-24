import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:cricketapp/modules/common/app_bar_title.dart';
import 'package:cricketapp/modules/home/controllers/home_controller.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../common/fixture_card_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          actions: [
            const Icon(
              Icons.notifications_outlined,
            ),
            const SizedBox(
              width: 10.0,
            ),
            IconButton(
              onPressed: () => Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
              icon: const Icon(Icons.sunny),
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
          title: const AppBarTitle(),
        ),
        body: !controller.loading.value
            ? controller.fixtures.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 320,
                          width: double.maxFinite,
                          child: PageView.builder(
                            itemCount: controller.fixtures.length,
                            onPageChanged: (value) => {controller.pageIndex.value = value},
                            itemBuilder: (context, index) {
                              final model = controller.fixtures[index];
                              return (model.showNativeAdd && controller.nativeAdIsLoaded.value)
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 80.0, left: 10.0, right: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(left: 5, right: 5),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(Radius.circular(3)),
                                            ),
                                            child: const Text(
                                              "Ad",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                          ConstrainedBox(
                                              constraints: const BoxConstraints(
                                                minWidth: 320, // minimum recommended width
                                                minHeight: 90, // minimum recommended height
                                                maxWidth: 400,
                                                maxHeight: 200,
                                              ),
                                              child: AdWidget(ad: controller.nativeAd!)),
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () => {Get.toNamed(Routes.MATCH_INFO, arguments: model.id)},
                                      child: FixtureCardView(showDate: false, model: model, showButtons: true),
                                    );
                            },
                          ),
                        ),
                        if (controller.fixtures.isNotEmpty)
                          SizedBox(
                            width: Get.mediaQuery.size.width * 0.9,
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: CarouselIndicator(
                                  width: 4,
                                  height: 4,
                                  space: 4,
                                  color: Theme.of(context).tabBarTheme.unselectedLabelColor!,
                                  activeColor: Theme.of(context).tabBarTheme.labelColor!,
                                  count: controller.fixtures.length,
                                  index: controller.pageIndex.value,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          primary: false,
                          childAspectRatio: 1.25,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            customButton(title: "TOP\nINTERNATIONAL TEAMS", index: 1),
                            customButton(title: "TOP\nALL ROUNDERS", index: 2),
                            customButton(title: "TOP\nBATTERS", index: 3),
                            customButton(title: "TOP\nBOWLERS", index: 4),
                          ],
                        )
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20),
                            child: Text(
                              textAlign: TextAlign.center,
                              controller.appService.connected.value
                                  ? controller.errorMessage
                                  : "Please check your internet connection and try again.",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.refreshIt(),
                          icon: const Icon(
                            Icons.refresh,
                            size: 28,
                          ),
                        )
                      ],
                    ),
                  )
            : Utils.progressIndicator(animController: controller.animController),
      ),
    );
  }

  Widget customButton({required String title, required int index}) {
    return GestureDetector(
      onTap: () => {
        Get.toNamed(index == 1 ? Routes.TEAM_RANKING : Routes.PLAYER_RANKING,
            arguments: {"id": index, "title": title.replaceAll("\n", " ")})
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              spreadRadius: 1,
              offset: const Offset(0.0, 0.0),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/rank.png",
                width: 60,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
