import 'package:cricketapp/modules/common/fixture_card_view.dart';
import 'package:cricketapp/modules/series-info/series_info_controller.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SeriesInfoView extends GetView<SeriesInfoController> {
  const SeriesInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: controller.currentIndex,
      length: controller.tabLength,
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              controller.title.value,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48.0),
              child: !controller.loading.value
                  ? TabBar(
                      controller: controller.tabController,
                      isScrollable: true,
                      onTap: (index) => {},
                      tabs: [
                        const Tab(
                          child: Text('Fixtures & Results'),
                        ),
                        const Tab(
                          child: Text('Teams'),
                        ),
                        Tab(
                          child: Text(controller.leagueId != 0 ? 'Points' : 'Series Stats'),
                        ),
                        const Tab(
                          child: Text('Info'),
                        ),
                      ],
                    )
                  : const Text(""),
            ),
          ),
          body: !controller.loading.value
              ? TabBarView(
                  controller: controller.tabController,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              controller.fixturesList.isNotEmpty
                                  ? ListView.builder(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: controller.fixturesList.length,
                                      itemBuilder: ((_, index) {
                                        final match = controller.fixturesList[index];
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
                                              : FixtureCardView(showDate: controller.canShowDate(index), model: match, showButtons: false),
                                        );
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
                                            onPressed: () => controller.refreshStageInfo(),
                                            icon: const Icon(
                                              Icons.refresh,
                                              size: 28,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              !controller.squadLoading.value
                                  ? controller.teamsList.isNotEmpty
                                      ? ListView.builder(
                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller.teamsList.length,
                                          itemBuilder: ((_, index) {
                                            final squad = controller.teamsList[index];
                                            return InkWell(
                                              onTap: () => {controller.navigateToTeamDetails(index)},
                                              child: Card(
                                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Row(
                                                    children: [
                                                      ClipOval(
                                                        child: SizedBox.fromSize(
                                                          size: const Size.fromRadius(24), // Image radius
                                                          child: squad.imagePath.isNotEmpty
                                                              ? FadeInImage.assetNetwork(
                                                                  width: 24,
                                                                  height: 24,
                                                                  fit: BoxFit.cover,
                                                                  placeholder: "assets/images/loading.gif",
                                                                  image: squad.imagePath,
                                                                )
                                                              : Image.asset(
                                                                  "assets/images/placeholder.png",
                                                                  width: 24,
                                                                  height: 24,
                                                                ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10.0,
                                                      ),
                                                      Text(
                                                        squad.name,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
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
                                                        ? "No data found!"
                                                        : "Please check your internet connection and try again.",
                                                    style: const TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () => controller.refreshStageInfo(),
                                                icon: const Icon(
                                                  Icons.refresh,
                                                  size: 28,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                  : Utils.progressIndicator(animController: controller.animController),
                            ],
                          ),
                        ),
                      ],
                    ),
                    controller.leagueId != 0
                        ? SingleChildScrollView(
                            child: !controller.pointsLoading.value
                                ? controller.pointsList.isNotEmpty
                                    ? Container(
                                        width: double.maxFinite,
                                        margin: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
                                        decoration: BoxDecoration(
                                          color: Get.theme.primaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                                          boxShadow: [
                                            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 5, offset: const Offset(0, 1)),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: double.maxFinite,
                                              decoration: BoxDecoration(
                                                color: Get.theme.scaffoldBackgroundColor,
                                                borderRadius:
                                                    const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 16.0, top: 8, right: 16, bottom: 5),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "Teams",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 33.0,
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          pointHear("M"),
                                                          pointHear("W"),
                                                          pointHear("L"),
                                                          pointHear("T"),
                                                          pointHear("N/R"),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            ListView.builder(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: controller.pointsList.length,
                                              itemBuilder: ((_, index) {
                                                final points = controller.pointsList[index];
                                                return InkWell(
                                                  onTap: () => {},
                                                  child: SizedBox(
                                                    width: double.maxFinite,
                                                    child: Column(
                                                      children: [
                                                        const Divider(height: 1),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 16.0, top: 10, right: 26, bottom: 10),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                "${index + 1}",
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 14.0,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 10.0,
                                                              ),
                                                              SizedBox(
                                                                width: 40,
                                                                child: Text(
                                                                  points.team.code.toUpperCase(),
                                                                  style: const TextStyle(
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 24.0,
                                                              ),
                                                              Expanded(
                                                                  child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text("${points.played}"),
                                                                  Text("${points.won}"),
                                                                  Text("${points.lost}"),
                                                                  Text("${points.draw}"),
                                                                  Text("${points.netToRunRate}"),
                                                                ],
                                                              )),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
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
                                                      ? controller.pointsErrorMessage
                                                      : "Please check your internet connection and try again.",
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () => controller.refreshStageInfo(),
                                              icon: const Icon(
                                                Icons.refresh,
                                                size: 28,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                : Utils.progressIndicator(animController: controller.animController),
                          )
                        : !controller.statsLoading.value
                            ? controller.seriesStats.isNotEmpty
                                ? ListView.builder(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.seriesStats.length,
                                    itemBuilder: ((_, index) {
                                      final stat = controller.seriesStats[index];
                                      return Container(
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0),
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
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 14.0, top: 14.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      controller.type.toUpperCase(),
                                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Divider(
                                              height: 1.0,
                                              color: Get.theme.dividerColor,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      ClipOval(
                                                        child: SizedBox.fromSize(
                                                          size: const Size.fromRadius(24), // Image radius
                                                          child: stat.visitorTeam.imagePath.isNotEmpty
                                                              ? FadeInImage.assetNetwork(
                                                                  width: 24,
                                                                  height: 24,
                                                                  fit: BoxFit.cover,
                                                                  placeholder: "assets/images/loading.gif",
                                                                  image: stat.visitorTeam.imagePath,
                                                                )
                                                              : Image.asset(
                                                                  "assets/images/placeholder.png",
                                                                  width: 24,
                                                                  height: 24,
                                                                ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Text(
                                                        stat.localTeam.code,
                                                        textAlign: TextAlign.end,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16.0,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "${stat.wonMatchVisitor} - ${stat.wonMatchLocal}",
                                                        style: TextStyle(
                                                          overflow: TextOverflow.fade,
                                                          fontSize: 32,
                                                          fontWeight: FontWeight.w500,
                                                          color: Get.isDarkMode ? Colors.white : Colors.black54,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${stat.played}/${stat.total} played",
                                                        style: TextStyle(
                                                          overflow: TextOverflow.fade,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Get.isDarkMode ? Colors.white60 : Colors.black54,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      ClipOval(
                                                        child: SizedBox.fromSize(
                                                          size: const Size.fromRadius(24), // Image radius
                                                          child: stat.localTeam.imagePath.isNotEmpty
                                                              ? FadeInImage.assetNetwork(
                                                                  width: 24,
                                                                  height: 24,
                                                                  fit: BoxFit.cover,
                                                                  placeholder: "assets/images/loading.gif",
                                                                  image: stat.localTeam.imagePath,
                                                                )
                                                              : Image.asset(
                                                                  "assets/images/placeholder.png",
                                                                  width: 24,
                                                                  height: 24,
                                                                ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Text(
                                                        stat.localTeam.code,
                                                        textAlign: TextAlign.end,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16.0,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 14.0, left: 14.0, right: 14.0),
                                              child: Center(
                                                child: Text(
                                                  controller.title.value,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.fade,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Get.isDarkMode ? Colors.white60 : Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
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
                                                  ? "No data found!"
                                                  : "Please check your internet connection and try again.",
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => controller.refreshStageInfo(),
                                          icon: const Icon(
                                            Icons.refresh,
                                            size: 28,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                            : const Text("Loading..."),
                    Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              !controller.loading.value
                                  ? controller.fixturesList.isNotEmpty
                                      ? Container(
                                          width: double.maxFinite,
                                          margin: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
                                          decoration: BoxDecoration(
                                            color: Get.theme.primaryColor,
                                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                                            boxShadow: [
                                              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 5, offset: const Offset(0, 1)),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Series",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        controller.title.value,
                                                        textAlign: TextAlign.end,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          overflow: TextOverflow.ellipsis,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(height: 1),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Format",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      controller.type.value,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                                        ? controller.pointsErrorMessage
                                                        : "Please check your internet connection and try again.",
                                                    style: const TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () => controller.refreshStageInfo(),
                                                icon: const Icon(
                                                  Icons.refresh,
                                                  size: 28,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                  : Utils.progressIndicator(animController: controller.animController),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Utils.progressIndicator(animController: controller.animController),
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
      }),
    );
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
