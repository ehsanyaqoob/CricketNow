import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cricketapp/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppService extends GetxService {
  late GetStorage _box;

  final showFavourite = true.obs;
  final favouriteTeamId = 0.obs;
  late StreamSubscription<ConnectivityResult> networkListener;
  final connected = false.obs;

  Future<AppService> init() async {
    networkListener = Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        connected.value = true;
      } else {
        connected.value = false;
      }
    });

    await GetStorage.init();
    _box = GetStorage();
    showFavourite.value = _box.read<bool>(Constants.SHOW_FAVOURITE_KEY) ?? true;
    favouriteTeamId.value = _box.read<int>(Constants.FAV_TEAM_ID_KEY) ?? 0;
    showFavourite.listen((v) {
      _box.write(Constants.SHOW_FAVOURITE_KEY, v);
    });
    favouriteTeamId.listen((v) {
      _box.write(Constants.FAV_TEAM_ID_KEY, v);
    });
    return this;
  }

  @override
  void onClose() {
    networkListener.cancel();
    super.onClose();
  }
}
