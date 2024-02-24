import 'package:get/get.dart';

import 'match_details_controller.dart';

class MatchDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchDetailsController>(() => MatchDetailsController());
  }
}
