import 'package:cricketapp/modules/squad/squad_controller.dart';
import 'package:get/get.dart';

class SquadBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SquadController>(() => SquadController());
  }
}
