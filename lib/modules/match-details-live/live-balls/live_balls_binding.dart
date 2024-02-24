import 'package:cricketapp/modules/match-details-live/live-balls/live_balls_controller.dart';
import 'package:get/get.dart';

class LiveBallsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveBallsController>(() => LiveBallsController());
  }
}
