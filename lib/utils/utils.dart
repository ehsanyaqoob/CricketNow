import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Widget progressIndicator(
      {required AnimationController animController}) {
    Tween<double> tween = Tween(begin: 0.75, end: 1);
    return Center(
      child: SizedBox(
        height: 48,
        width: 48,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            ScaleTransition(
              scale: tween.animate(CurvedAnimation(
                  parent: animController, curve: Curves.easeInCirc)),
              child: Center(
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: Image.asset("assets/images/ic_logo.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 48,
              width: 48,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                strokeWidth: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> shareApp() async {
    await FlutterShare.share(
        title: 'CRICNOW -Live Line App',
        text:
            'CRICNOW\nYour one-stop destination for live scrores and updates, Let\'s download and enjoy!',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.worldcup.cricket.matches.schedule.live.updates',
        chooserTitle: 'Share to:');
  }

  static Future openUrl({required Uri uri}) async {
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      throw 'Could not launch $uri';
    }
  }

  static String getCountryFlag(String? img) {
    if (img == null) return "assets/images/placeholder.png";
    final value = img.toString().toLowerCase();
    if (value.contains("pak")) {
      return "assets/images/pak.png";
    } else if (value.contains("uae")) {
      return "assets/images/uae.png";
    } else if (value.contains("afg")) {
      return "assets/images/afg.png";
    } else if (value.contains("aus")) {
      return "assets/images/aus.png";
    } else if (value.contains("ban")) {
      return "assets/images/ban.png";
    } else if (value.contains("ind")) {
      return "assets/images/ind.png";
    } else if (value.contains("ire")) {
      return "assets/images/ire.png";
    } else if (value.contains("nam")) {
      return "assets/images/nam.png";
    } else if (value.contains("nep")) {
      return "assets/images/nep.png";
    } else if (value.contains("net")) {
      return "assets/images/net.png";
    } else if (value.contains("new")) {
      return "assets/images/new.png";
    } else if (value.contains("oma")) {
      return "assets/images/oma.png";
    } else if (value.contains("sco")) {
      return "assets/images/sco.png";
    } else if (value.contains("sou")) {
      return "assets/images/sou.png";
    } else if (value.contains("sri")) {
      return "assets/images/sri.png";
    } else if (value.contains("wes")) {
      return "assets/images/wes.png";
    } else if (value.contains("zim")) {
      return "assets/images/zim.png";
    } else if (value.contains("eng")) {
      return "assets/images/eng.png";
    } else {
      return "assets/images/placeholder.png";
    }
  }
}
