import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(Get.find<AppService>().showFavourite.value
          ? Routes.FAVOURITE
          : AppPages.initialRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash_back.png"),
                fit: BoxFit.fill)),
        child: Center(
          child: Image.asset("assets/images/cric_logo.png",
              width: MediaQuery.of(context).size.width * 0.25),
        ),
      ),
    );
  }
}
