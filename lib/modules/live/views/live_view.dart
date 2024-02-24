import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/modules/common/app_bar_title.dart';
import 'package:cricketapp/modules/common/card_view_item.dart';
import 'package:cricketapp/modules/common/fixture_card_view.dart';
import 'package:cricketapp/modules/live/controllers/live_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LiveView extends GetView<LiveController> {
  const LiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: controller.tabLength,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: TabBar(
              controller: controller.tabController,
              isScrollable: true,
              onTap: (index) => {},
              tabs: const [
                Tab(
                  child: Text('Live'),
                ),
                Tab(
                  child: Text('Upcoming'),
                ),
                Tab(
                  child: Text('Finished'),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [
            Obx(() {
              return page(controller.liveLoading.value, controller.liveMatches, 0);
            }),
            Obx(() {
              return page(controller.upComingLoading.value, controller.upComingMatches, 1);
            }),
            Obx(() {
              return page(controller.finishedLoading.value, controller.finishedMatches, 2);
            }),
          ],
        ),
      ),
    );
  }

  Widget page(bool loading, List<Fixture> matchesList, int pageIndex) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              !loading
                  ? matchesList.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: matchesList.length,
                          itemBuilder: ((_, index) {
                            final match = matchesList[index];
                            return Container(
                                child: (match.showNativeAdd && controller.nativeAdIsLoaded.value)
                                    ? Padding(
                                        padding: const EdgeInsets.all(10.0),
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
                                                  minHeight: 320, // minimum recommended height
                                                  maxWidth: 360,
                                                  maxHeight: 360,
                                                ),
                                                child: AdWidget(ad: controller.nativeAd!)),
                                          ],
                                        ),
                                      )
                                    : FixtureCardView(
                                        showDate: controller.canShowDate(index, pageIndex), model: match, showButtons: false));
                          }),
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
                  : const CardViewItem() //Utils.progressIndicator(animController: controller.animController),
            ],
          ),
        ),
      ],
    );
  }
}
