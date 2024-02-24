import 'package:cricketapp/modules/news/controllers/news_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewsDetailsView extends GetView<NewsDetailsController> {
  const NewsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                collapseMode: CollapseMode.pin,
                title: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  width: Get.mediaQuery.size.width * 0.7,
                  color: Colors.black.withOpacity(0.3),
                  child: Text(
                    controller.blog.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                background: Image.network(
                  controller.blog.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0, right: 10, bottom: 10.0),
          child: Text(
            controller.blog.details,
            style: const TextStyle(
              fontSize: 16.0,
              overflow: TextOverflow.fade,
            ),
          ),
        )),
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
  }
}
