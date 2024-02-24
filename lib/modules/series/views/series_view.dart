import 'package:cricketapp/modules/common/app_bar_title.dart';
import 'package:cricketapp/modules/series/controllers/series_controller.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SeriesView extends GetView<SeriesController> {
  const SeriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Obx(
        () => controller.loading.value
            ? ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 14,
                itemBuilder: ((_, index) {
                  return Shimmer.fromColors(
                    baseColor: Get.isDarkMode ? Colors.white : Colors.black12,
                    highlightColor: Colors.white12,
                    child: Column(
                      children: [
                        Container(
                          height: 24,
                          width: double.maxFinite,
                          margin: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: Get.isDarkMode ? Colors.white12 : Colors.black,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            : controller.leagues.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 10, right: 16.0, bottom: 3),
                          child: Text(
                            "Leagues",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.leagues.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.SERIES_INFO, arguments: {
                                  'season_id': controller.leagues[index].seasonId,
                                  'league_id': controller.leagues[index].id,
                                  'stage_id': 0,
                                  'index': 0,
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                                color: Get.isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(height: 1),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        controller.leagues[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                          ),
                          child: Divider(height: 1),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0, top: 10, right: 16.0, bottom: 3),
                          child: Text(
                            "Series",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.only(bottom: 10),
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.stages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.SERIES_INFO, arguments: {
                                  'season_id': controller.leagues[index].seasonId,
                                  'league_id': 0,
                                  'stage_id': controller.stages[index].id,
                                  'index': 0,
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                                color: Get.isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(height: 1),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        controller.stages[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
      ),
    );
  }
}
