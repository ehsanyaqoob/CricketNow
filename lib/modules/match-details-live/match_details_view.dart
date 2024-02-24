import 'package:cricketapp/models/batting.dart';
import 'package:cricketapp/models/bowling.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'match_details_controller.dart';

class MatchDetailsView extends GetView<MatchDetailsController> {
  const MatchDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: controller.tabLength,
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              controller.fixture.value.type,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(260.0),
                child: !controller.loading.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14.0, top: 14.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${controller.fixture.value.status} • ${controller.fixture.value.type.toUpperCase()}",
                                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                                      ),
                                      Text(
                                        "${controller.fixture.value.round} • ${controller.fixture.value.venue.name}",
                                        maxLines: 1,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Get.isDarkMode ? Colors.white60 : Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (controller.fixture.value.status.toLowerCase() == "st" ||
                                  controller.fixture.value.status.toLowerCase() == "1st innings" ||
                                  controller.fixture.value.status.toLowerCase() == "2nd innings")
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 36,
                                    padding: const EdgeInsets.only(top: 5, right: 10, left: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(60),
                                      ),
                                    ),
                                    child: const Text(
                                      "Live",
                                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 1.0,
                            color: Get.theme.dividerColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(28), // Image radius
                                        child: controller.fixture.value.visitorTeam.imagePath.isNotEmpty
                                            ? FadeInImage.assetNetwork(
                                                width: 28,
                                                height: 28,
                                                fit: BoxFit.cover,
                                                placeholder: "assets/images/loading.gif",
                                                image: controller.fixture.value.visitorTeam.imagePath,
                                              )
                                            : Image.asset(
                                                "assets/images/placeholder.png",
                                                width: 28,
                                                height: 28,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                            controller.fixture.value.visitorTeam.code,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${controller.visitorTeamRuns.value.score}-${controller.visitorTeamRuns.value.wickets}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22.0,
                                          ),
                                        ),
                                        Text(
                                          "${controller.visitorTeamRuns.value.overs} OVERS",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(controller.fixture.value.localTeam.code,
                                              textAlign: TextAlign.end,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        ),
                                        Text(
                                          "${controller.localTeamRuns.value.score}-${controller.localTeamRuns.value.wickets}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22.0,
                                          ),
                                        ),
                                        Text(
                                          "${controller.localTeamRuns.value.overs} OVERS",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(28), // Image radius
                                        child: controller.fixture.value.localTeam.imagePath.isNotEmpty
                                            ? FadeInImage.assetNetwork(
                                                width: 28,
                                                height: 28,
                                                fit: BoxFit.cover,
                                                placeholder: "assets/images/loading.gif",
                                                image: controller.fixture.value.localTeam.imagePath,
                                              )
                                            : Image.asset(
                                                "assets/images/placeholder.png",
                                                width: 28,
                                                height: 28,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0, left: 14.0, right: 14.0),
                            child: Center(
                                child: Text(
                              controller.fixture.value.note.toUpperCase(),
                              style: TextStyle(
                                overflow: TextOverflow.fade,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Get.isDarkMode ? Colors.white60 : Colors.black54,
                              ),
                            )),
                          ),
                          TabBar(
                            controller: controller.tabController,
                            isScrollable: true,
                            onTap: (index) => {},
                            tabs: const [
                              Tab(
                                child: Text('Live'),
                              ),
                              Tab(
                                child: Text('Scoreboard'),
                              ),
                              Tab(
                                child: Text('Teams'),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Utils.progressIndicator(animController: controller.animController)),
          ),
          body: TabBarView(
            controller: controller.tabController,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.liveBatting.isNotEmpty) tableBatters(context, controller.liveBatting),
                    if (controller.liveBowling.isNotEmpty) tableBowlers(context, controller.liveBowling),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5.0,
                            spreadRadius: 1,
                            offset: const Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 12, right: 10, bottom: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Live Updates: (Ball By Ball)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {Get.toNamed(Routes.LIVE_BALLS, arguments: controller.fixture.value.id)},
                                  child: const Text(
                                    "More",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 1.0, color: Get.theme.dividerColor),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SizedBox(
                              height: 60,
                              child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.balls.length,
                                controller: controller.scrolController,
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                itemBuilder: ((_, index) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (controller.balls[index].isOvered)
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 10.0),
                                            child: Text(
                                              "Overs: ${controller.balls[index].overs}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        margin: const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: controller.balls[index].score.isWicket
                                              ? Colors.red
                                              : controller.balls[index].score.noball == 1 ||
                                                      controller.balls[index].score.legBye == 1 ||
                                                      controller.balls[index].score.bye == 1
                                                  ? Colors.amber
                                                  : Colors.white10,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 1.0,
                                              offset: const Offset(0.0, 0.0),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.balls[index].score.isWicket
                                                ? "W"
                                                : controller.balls[index].score.noball == 1
                                                    ? "NO${controller.balls[index].score.noballRuns}"
                                                    : controller.balls[index].score.legBye == 1
                                                        ? "LB${controller.balls[index].score.legBye}"
                                                        : controller.balls[index].score.bye == 1
                                                            ? "BY${controller.balls[index].score.bye}"
                                                            : controller.balls[index].score.runs.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0,
                                              color: controller.balls[index].score.noball == 1 ||
                                                      controller.balls[index].score.legBye == 1 ||
                                                      controller.balls[index].score.bye == 1
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 10, right: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            controller.fixture.value.visitorTeam.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "(${controller.visitorTeamRuns.value.score}-${controller.visitorTeamRuns.value.wickets})",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    !controller.scroeBoardLoading.value
                        ? controller.visitorBatters.isNotEmpty
                            ? tableBatters(context, controller.visitorBatters)
                            : const Center(child: Text("No Record found."))
                        : const Center(child: Text("Loading...")),
                    controller.visitorBowlers.isNotEmpty ? tableBowlers(context, controller.visitorBowlers) : const Text(""),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 10, right: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            controller.fixture.value.localTeam.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "(${controller.localTeamRuns.value.score}-${controller.localTeamRuns.value.wickets})",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    controller.localBatters.isNotEmpty
                        ? tableBatters(context, controller.localBatters)
                        : const Center(child: Text("No Record found.")),
                    controller.localBowlers.isNotEmpty ? tableBowlers(context, controller.localBowlers) : const Text("")
                  ],
                ),
              ),
              controller.loadingSquad.value
                  ? Utils.progressIndicator(animController: controller.animController)
                  : controller.visitorTeamSquad.squad.isNotEmpty && controller.localTeamSquad.squad.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 16),
                            SizedBox(
                              width: Get.mediaQuery.size.width * 0.8,
                              child: SegmentedButton<int>(
                                segments: controller.segments,
                                selected: <int>{controller.segmentSelection.value},
                                onSelectionChanged: (Set<int> team) => {controller.loadPlayers(team)},
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "PLAYER",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                        color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Text(
                                      "ROLE",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                        color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: controller.loadingSquad.value
                                  ? Utils.progressIndicator(animController: controller.animController)
                                  : controller.players.isNotEmpty
                                      ? ListView.builder(
                                          primary: false,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: controller.players.length,
                                          itemBuilder: ((_, index) {
                                            final player = controller.players[index];
                                            return InkWell(
                                              onTap: () => {},
                                              child: SizedBox(
                                                width: double.maxFinite,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const Divider(height: 1),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Flex(
                                                        direction: Axis.horizontal,
                                                        children: [
                                                          Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.tight,
                                                            child: Text(
                                                              player.fullName,
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 14.0,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            flex: 1,
                                                            fit: FlexFit.tight,
                                                            child: Text(
                                                              player.position.name,
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                        )
                                      : Center(child: Text(controller.squadErrorMessage)),
                            ),
                          ],
                        )
                      : const Center(
                          child: Text("No record found."),
                        )
            ],
          ),
          bottomNavigationBar: controller.bannerLoaded.value
              ? SafeArea(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12.0, bottom: 10.0),
                    color: Colors.transparent,
                    width: controller.bannerAd!.size.width.toDouble(),
                    height: controller.bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: controller.bannerAd!),
                  ),
                )
              : const SizedBox(
                  width: 1,
                ),
        ),
      ),
    );
  }

  Table tableBowlers(BuildContext context, List<Bowling> bowlingList) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        tableRowHeader(context, "BOWLERS", "O", "M", "R", "W", "ECO"),
        for (final bowling in bowlingList)
          tableRow(bowling.bowler.firstname, bowling.bowler.bowlingStyle, bowling.active, null, bowling.overs, bowling.medians,
              bowling.runs, bowling.wickets, bowling.rate),
      ],
    );
  }

  Table tableBatters(BuildContext context, List<Batting> battersList) {
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
        3: FlexColumnWidth(),
        4: FlexColumnWidth(),
        5: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        tableRowHeader(context, "BATTERS", "R", "B", "4S", "6S", "SR"),
        for (final batting in battersList)
          tableRow(batting.batsman.firstname, batting.batsman.battingStyle, batting.active, batting.score, null, batting.ball,
              batting.fourX, batting.sixX, batting.rate),
      ],
    );
  }

  Widget pointHear(BuildContext context, String txt) {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.transparent,
        fontWeight: FontWeight.w600,
        fontSize: 12.0,
        shadows: [Shadow(color: Theme.of(context).tabBarTheme.unselectedLabelColor!, offset: const Offset(0, -3))],
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).tabBarTheme.unselectedLabelColor,
        decorationThickness: 2,
      ),
    );
  }

  TableRow tableRowHeader(BuildContext context, String name, String v1, String v2, String v3, String v4, String v5) {
    return TableRow(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 0.8, color: Get.theme.dividerColor),
      )),
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
            child: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
                color: Theme.of(context).tabBarTheme.unselectedLabelColor,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: pointHear(context, v1),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: pointHear(context, v2),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: pointHear(context, v3),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: pointHear(context, v4),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: pointHear(context, v5),
          ),
        ),
      ],
    );
  }

  TableRow tableRow(String name, String playingStyle, bool active, int? v0, double? v1, int v2, int v3, int v4, double v5) {
    return TableRow(
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          border: Border(
            top: BorderSide(width: 0.5, color: Get.theme.dividerColor),
          )),
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  active ? "$name *" : name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text(
                    "($playingStyle)",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                      color: Theme.of(Get.context!).tabBarTheme.unselectedLabelColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            (v0 ?? (v1 ?? 0)).toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            v2.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            v3.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            v4.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              v5.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
