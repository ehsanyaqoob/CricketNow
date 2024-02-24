import 'package:cricketapp/modules/squad/squad_controller.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquadView extends GetView<SquadController> {
  const SquadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            controller.teamSquad.name,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        body: Stack(
          children: [
            !controller.loading.value
                ? controller.teamSquad.squad.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.teamSquad.squad.length,
                        itemBuilder: ((_, index) {
                          final model = controller.teamSquad.squad[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(
                                          24), // Image radius
                                      child: model.firstname.isNotEmpty
                                          ? FadeInImage.assetNetwork(
                                              width: 24,
                                              height: 24,
                                              fit: BoxFit.cover,
                                              placeholder:
                                                  "assets/images/loading.gif",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        model.firstname,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        model.position.name,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white54),
                                      ),
                                    ],
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
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
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
                : Utils.progressIndicator(
                    animController: controller.animController),
          ],
        ),
      ),
    );
  }
}
