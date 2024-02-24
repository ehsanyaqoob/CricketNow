import 'package:cricketapp/modules/common/app_bar_title.dart';
import 'package:cricketapp/modules/news/controllers/news_controller.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Obx(
        () => !controller.loading.value
            ? controller.blogsList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.blogsList.length,
                    itemBuilder: ((_, index) {
                      final model = controller.blogsList[index];
                      return GestureDetector(
                        onTap: () => {Get.toNamed(Routes.NEWS_DETAILS, arguments: model)},
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                          child: (model.showAdd && controller.nativeAdIsLoaded.value)
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
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                                      child: model.imageUrl.isNotEmpty
                                          ? FadeInImage.assetNetwork(
                                              width: double.maxFinite,
                                              height: 200,
                                              fit: BoxFit.cover,
                                              placeholderScale: 0.1,
                                              placeholderFit: BoxFit.contain,
                                              placeholder: "assets/images/loading.gif",
                                              image: model.imageUrl,
                                            )
                                          : Image.asset(
                                              "assets/images/placeholder.png",
                                              width: 28,
                                              height: 28,
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20, bottom: 10),
                                      child: Text(
                                        model.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                                      child: Text(
                                        model.formattedDate,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).tabBarTheme.unselectedLabelColor,
                                        ),
                                      ),
                                    ),
                                  ],
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
}
