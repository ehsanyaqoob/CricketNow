import 'package:cricketapp/utils/open_app_ad_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppLifecycleObserver {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleObserver({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}
