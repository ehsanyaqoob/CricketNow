import 'package:cricketapp/modules/favourite/teams_controller.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TeamsView extends GetView<TeamsController> {
  const TeamsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: Get.mediaQuery.size.height * 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select Your Favourite Team",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.offAllNamed(AppPages.initialRoute),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: !controller.loading.value
                      ? controller.teamsList.isNotEmpty
                          ? Stack(
                              children: [
                                ListView.builder(
                                  padding: const EdgeInsets.only(top: 10, bottom: 66),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.teamsList.length,
                                  primary: false,
                                  itemBuilder: ((_, index) {
                                    final model = controller.teamsList[index];
                                    return InkWell(
                                      onTap: () => {controller.onClickItem(model.id)},
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: controller.selectedItem.value == model.id ? Colors.red : Colors.transparent),
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Row(
                                            children: [
                                              ClipOval(
                                                child: SizedBox.fromSize(
                                                  size: const Size.fromRadius(24), // Image radius
                                                  child: model.imagePath.isNotEmpty
                                                      ? FadeInImage.assetNetwork(
                                                          placeholderErrorBuilder: (a, b, c) => Image.asset(
                                                            "assets/images/placeholder.png",
                                                            width: 24,
                                                            height: 24,
                                                          ),
                                                          width: 24,
                                                          height: 24,
                                                          fit: BoxFit.cover,
                                                          placeholder: "assets/images/loading.gif",
                                                          image: model.imagePath,
                                                        )
                                                      : Image.asset(
                                                          "assets/images/placeholder.png",
                                                          width: 24,
                                                          height: 24,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 14.0,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    model.name,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    model.code,
                                                    style: const TextStyle(fontSize: 14, color: Colors.white54),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                if (controller.selectedItem.value > 0)
                                  Positioned(
                                    bottom: 20,
                                    right: 20,
                                    child: GestureDetector(
                                      onTap: () => controller.onClickContinue(),
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: const BorderRadius.all(Radius.circular(7)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 1.0,
                                              spreadRadius: 3,
                                              offset: const Offset(0.0, 0.0),
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Continue",
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
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
                            )
                      : Utils.progressIndicator(animController: controller.animController)),
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
      ),
    );
  }
}
