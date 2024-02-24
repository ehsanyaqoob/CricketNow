import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CardViewItem extends StatelessWidget {
  const CardViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: 4,
      itemBuilder: ((_, index) {
        return Column(
          children: [
            Container(
              width: 90,
              height: 38,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
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
                child: Shimmer.fromColors(
                  baseColor: Get.isDarkMode ? Colors.white : Colors.black12,
                  highlightColor: Colors.white12,
                  child: Container(
                    height: 16,
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? Colors.white12 : Colors.black,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
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
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Shimmer.fromColors(
                  baseColor: Get.isDarkMode ? Colors.white : Colors.black12,
                  highlightColor: Colors.white12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18, left: 10, right: 10),
                        child: placeHolder(width: Get.mediaQuery.size.width * 0.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: placeHolder(width: double.maxFinite),
                      ),
                      const SizedBox(height: 10),
                      Divider(
                        height: 1.0,
                        color: Get.theme.dividerColor,
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(32), // Image radius
                                    child: placeHolder(width: 32.0),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    placeHolder(width: 60.0),
                                    const SizedBox(height: 10.0),
                                    placeHolder(width: 68.0),
                                    const SizedBox(height: 10.0),
                                    placeHolder(width: 74.0),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    placeHolder(width: 60.0),
                                    const SizedBox(height: 10.0),
                                    placeHolder(width: 68.0),
                                    const SizedBox(height: 10.0),
                                    placeHolder(width: 74.0),
                                  ],
                                ),
                                const SizedBox(width: 10.0),
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(32), // Image radius
                                    child: placeHolder(width: 32.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18),
                        child: placeHolder(width: 100.0),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        );
      }),
    );
  }

  Widget placeHolder({required width}) {
    return Container(
      height: 12,
      width: width,
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.white12 : Colors.black,
        borderRadius: const BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
    );
  }
}
