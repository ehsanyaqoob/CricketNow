import 'package:cricketapp/modules/topranking/top_ranking_controller.dart';
import 'package:get/get.dart';

class TopRankingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopRankingController>(() => TopRankingController());
  }
}
