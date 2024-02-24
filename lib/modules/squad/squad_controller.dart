import 'package:cricketapp/models/team_squad_details.dart';
import 'package:cricketapp/repository/matches_repository.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SquadController extends GetxController with GetTickerProviderStateMixin {
  late MatchesRepository _matchesRepository;
  late AnimationController animController;
  Tween<double> tween = Tween(begin: 0.75, end: 1);

  String errorMessage = "";
  final loading = false.obs;
  late List<int> ids;
  TeamSquadDetails teamSquad = TeamSquadDetails();
  late AppService appService;

  SquadController() {
    _matchesRepository = MatchesRepository();
  }

  @override
  void onInit() {
    appService = Get.find<AppService>();
    animController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    animController.repeat(reverse: true);
    ids = Get.arguments as List<int>;
    super.onInit();
    _getTeamPlayersList();
  }

  Future<void> _getTeamPlayersList() async {
    try {
      loading.value = true;
      teamSquad =
          await _matchesRepository.getSquadByTeamAndSeasonId(ids[0], ids[1]);
    } catch (e) {
      errorMessage = "Could not found data!";
    }
    loading.value = false;
  }

  void refreshIt() {
    _getTeamPlayersList();
  }

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }
}
