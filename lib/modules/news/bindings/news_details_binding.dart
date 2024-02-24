import 'package:cricketapp/modules/news/controllers/news_details_controller.dart';
import 'package:get/get.dart';

class NewsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailsController>(() => NewsDetailsController());
  }
}
