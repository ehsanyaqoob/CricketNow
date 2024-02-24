import 'package:cricketapp/modules/series-info/series_info_controller.dart';
import 'package:get/get.dart';

class SeriesInfoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeriesInfoController>(() => SeriesInfoController());
  }
}
