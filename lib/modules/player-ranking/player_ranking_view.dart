import 'package:cricketapp/modules/player-ranking/player_ranking_controller.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class PlayerRankingView extends GetView<PlayerRankingController> {
  const PlayerRankingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            controller.title,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: !controller.loading.value
                ? controller.tabs.isNotEmpty
                    ? TabBar(
                        controller: controller.tabController,
                        isScrollable: true,
                        onTap: (index) => {},
                        tabs: [
                          for (final tab in controller.tabs.entries)
                            Tab(
                              child: Text(tab.key.toUpperCase()),
                            ),
                        ],
                      )
                    : const Text("")
                : const Text(""),
          ),
        ),
        body: controller.loading.value
            ? Utils.progressIndicator(animController: controller.animController)
            : controller.tabs.isNotEmpty
                ? TabBarView(
                    controller: controller.tabController,
                    children: [
                      for (final tab in controller.tabs.entries)
                        tab.value.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.only(top: 10, bottom: 10),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: tab.value.length,
                                itemBuilder: ((_, index) {
                                  final model = tab.value[index];
                                  return Container(
                                    width: double.maxFinite,
                                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                          child: Text(
                                            "#${model.rank}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.mediaQuery.size.width * 0.35,
                                          child: Text(
                                            model.player,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5.0),
                                        Image.asset(
                                          model.teamUrl,
                                          width: 30,
                                        ),
                                        Text(
                                          model.team.length > 3 ? model.team.substring(0, 3) : model.team,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Column(
                                          children: [
                                            Text(
                                              "Rating",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.0,
                                                color: Get.isDarkMode ? Colors.white60 : Colors.black54,
                                              ),
                                            ),
                                            Text(
                                              model.rating.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              )
                            : Center(
                                child: Text(controller.errorMessage),
                              ),
                    ],
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
                  ),
        bottomNavigationBar: controller.bannerLoaded.value
            ? SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(top: 12.0, bottom: 10.0),
                  color: Colors.transparent,
                  width: controller.bannerAd!.size.width.toDouble(),
                  height: controller.bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: controller.bannerAd!),
                ),
              )
            : const SizedBox(
                width: 1,
              ),
      );
    });
  }

  Widget pointHear(String txt) {
    return Text(
      txt,
      style: TextStyle(
        color: Colors.transparent,
        fontWeight: FontWeight.w600,
        fontSize: 13.0,
        shadows: const [Shadow(color: Colors.white, offset: Offset(0, -3))],
        decoration: TextDecoration.underline,
        decorationColor: Get.isDarkMode ? Colors.white : Colors.black,
        decorationThickness: 2,
      ),
    );
  }
}
