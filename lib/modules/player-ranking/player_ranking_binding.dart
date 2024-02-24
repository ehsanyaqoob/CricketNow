import 'package:cricketapp/modules/player-ranking/player_ranking_controller.dart';
import 'package:get/get.dart';

class PlayerRankingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayerRankingController>(() => PlayerRankingController());
  }
}
