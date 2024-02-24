import 'package:cricketapp/modules/match-details-live/live-balls/live_balls_controller.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LiveBallsView extends GetView<LiveBallsController> {
  const LiveBallsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Live Updates (Ball By Ball)",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        body: controller.loading.value
            ? Utils.progressIndicator(animController: controller.animController)
            : controller.oversList.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.oversList.length,
                    itemBuilder: ((_, index) {
                      final model = controller.oversList[index];
                      return Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 64,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  model.over.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                primary: false,
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(right: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    for (final ball in model.balls)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                color: ball.score.isWicket
                                                    ? Colors.red
                                                    : ball.score.noball == 1 ||
                                                            ball.score.legBye == 1 ||
                                                            ball.score.bye == 1 ||
                                                            !ball.score.ball
                                                        ? Colors.amber
                                                        : Colors.white10,
                                                borderRadius: const BorderRadius.all(
                                                  Radius.circular(20.0),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  ball.score.isWicket ? "W" : ball.score.runs.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.0,
                                                    color: ball.score.noball == 1 ||
                                                            ball.score.legBye == 1 ||
                                                            ball.score.bye == 1 ||
                                                            !ball.score.ball
                                                        ? Colors.black
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              ball.score.name,
                                              style: const TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
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
