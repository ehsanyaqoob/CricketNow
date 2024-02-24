import 'package:cricketapp/modules/favourite/teams_controller.dart';
import 'package:get/get.dart';

class TeamsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamsController>(() => TeamsController());
  }
}
