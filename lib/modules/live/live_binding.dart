import 'package:cricketapp/modules/live/controllers/live_controller.dart';
import 'package:get/get.dart';

class LiveBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveController>(() => LiveController());
  }
}
