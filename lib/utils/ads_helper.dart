import 'dart:io';

import 'package:flutter/foundation.dart';

class AdHelper {
  static String get openAppAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode ? 'ca-app-pub-3940256099942544/9257395921' : "ca-app-pub-7670389358728507/6295752909";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode ? 'ca-app-pub-3940256099942544/6300978111' : "ca-app-pub-7670389358728507/2377323696";
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return kDebugMode ? 'ca-app-pub-3940256099942544/2247696110' : "ca-app-pub-7670389358728507/7512549506";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
