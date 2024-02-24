import 'package:cricketapp/modules/common/app_bar_title.dart';
import 'package:cricketapp/modules/more/controllers/more_controller.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreView extends GetView<MoreController> {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        actions: [
          const Icon(
            Icons.notifications_outlined,
          ),
          const SizedBox(
            width: 10.0,
          ),
          IconButton(
            onPressed: () => Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark),
            icon: const Icon(Icons.sunny),
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
        title: const AppBarTitle(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () => {Get.toNamed(Routes.FAVOURITE)},
              child: const ListTile(
                leading: Icon(Icons.favorite_outlined),
                title: Text("My Favourite Team"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            InkWell(
              onTap: () => {Utils.openUrl(uri: Uri.parse("market://details?id=com.worldcup.cricket.matches.schedule.live.updates"))},
              child: const ListTile(
                leading: Icon(Icons.star_rate),
                title: Text("Rate Us"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            InkWell(
              onTap: () => {Utils.openUrl(uri: Uri.parse("market://details?id=com.worldcup.cricket.matches.schedule.live.updates"))},
              child: const ListTile(
                leading: Icon(Icons.file_download_outlined),
                title: Text("Check for update"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            InkWell(
              onTap: () => {_sendMail()},
              child: const ListTile(
                leading: Icon(Icons.report_problem_outlined),
                title: Text("Report a Problem"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            InkWell(
              onTap: () => {Utils.shareApp()},
              child: const ListTile(
                leading: Icon(Icons.share_outlined),
                title: Text("Invite Friends"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            InkWell(
              onTap: () => {Utils.openUrl(uri: Uri.parse("https://jainsstudio.com/about-us"))},
              child: const ListTile(
                leading: Icon(Icons.info_outlined),
                title: Text("About Us"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            InkWell(
              onTap: () => {Utils.openUrl(uri: Uri.parse("https://jainsstudio.com/privacy-policy/"))},
              child: const ListTile(
                leading: Icon(Icons.privacy_tip_outlined),
                title: Text("Privacy Policy"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              "Version: 1.0",
              style: TextStyle(
                color: Get.isDarkMode ? Colors.white54 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMail() async {
    String email = "admin@jainsstudio.com";
    Uri mail = Uri.parse("mailto:$email");
    await launchUrl(mail);
  }
}
