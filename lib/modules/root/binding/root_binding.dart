import 'package:cricketapp/modules/home/controllers/home_controller.dart';
import 'package:cricketapp/modules/live/controllers/live_controller.dart';
import 'package:cricketapp/modules/news/controllers/news_controller.dart';
import 'package:cricketapp/modules/series/controllers/series_controller.dart';
import 'package:cricketapp/modules/more/controllers/more_controller.dart';
import 'package:cricketapp/modules/root/controller/root_controller.dart';
import 'package:get/get.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LiveController>(() => LiveController());
    Get.lazyPut<SeriesController>(() => SeriesController());
    Get.lazyPut<NewsController>(() => NewsController());
    Get.lazyPut<MoreController>(() => MoreController());
  }
}
