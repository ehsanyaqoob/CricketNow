import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FixtureCardView extends GetView {
  const FixtureCardView(
      {super.key,
      required this.showDate,
      required this.model,
      required this.showButtons});

  final Fixture model;
  final bool showDate;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {Get.toNamed(Routes.MATCH_INFO, arguments: model.id)},
      child: Column(
        children: [
          if (showDate)
            Container(
              padding:
                  const EdgeInsets.only(left: 10, top: 7, right: 10, bottom: 7),
              margin: const EdgeInsets.only(top: 5, bottom: 0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 1.0,
                    spreadRadius: 0,
                    offset: const Offset(0.0, 0.0),
                  ),
                ],
              ),
              child: Text(
                model.formattedDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.isDarkMode ? Colors.white60 : Colors.black54,
                ),
              ),
            ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
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
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Column(
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
                              "${model.status} • ${model.type.toUpperCase()}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14.0),
                            ),
                            Text(
                              "${model.round} • ${model.venue.name.isEmpty ? "Stadium Not Decided" : model.venue.name}",
                              maxLines: 1,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Get.isDarkMode
                                    ? Colors.white60
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (model.status.toLowerCase() == "st" ||
                        model.status.toLowerCase() == "1st innings" ||
                        model.status.toLowerCase() == "2nd innings")
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 36,
                          padding: const EdgeInsets.only(
                              top: 5, right: 10, left: 20),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(60),
                            ),
                          ),
                          child: const Text(
                            "Live",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(height: 1.0, color: Get.theme.dividerColor),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 14, top: 16, right: 14, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(24), // Image radius
                              child: model.visitorTeam.imagePath.isNotEmpty
                                  ? FadeInImage.assetNetwork(
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.cover,
                                      placeholder: "assets/images/loading.gif",
                                      image: model.visitorTeam.imagePath,
                                    )
                                  : Image.asset(
                                      "assets/images/placeholder.png",
                                      width: 24,
                                      height: 24,
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.visitorTeam.code,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (model.runs.isNotEmpty)
                                Wrap(
                                  direction: Axis.vertical,
                                  alignment: WrapAlignment.end,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: [
                                    Text(
                                      "${model.runsVisitor != null ? model.runsVisitor?.score : 0}-${model.runsVisitor != null ? model.runsVisitor?.wickets : 0}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    Text(
                                      "${model.runsVisitor != null ? model.runsVisitor?.overs : 0} OVERS",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                model.localTeam.code,
                                textAlign: TextAlign.end,
                                maxLines: 1,
                                softWrap: false,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (model.runs.isNotEmpty)
                                Wrap(
                                  direction: Axis.vertical,
                                  alignment: WrapAlignment.end,
                                  crossAxisAlignment: WrapCrossAlignment.end,
                                  children: [
                                    Text(
                                      "${model.runsLocal != null ? model.runsLocal?.score : 0}-${model.runsLocal != null ? model.runsLocal?.wickets : 0}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    Text(
                                      "${model.runsLocal != null ? model.runsLocal?.overs : 0} OVERS",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(24), // Image radius
                              child: model.localTeam.imagePath.isNotEmpty
                                  ? FadeInImage.assetNetwork(
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.cover,
                                      placeholder: "assets/images/loading.gif",
                                      image: model.localTeam.imagePath,
                                    )
                                  : Image.asset(
                                      "assets/images/placeholder.png",
                                      width: 24,
                                      height: 24,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (model.time.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, top: 10, right: 14.0, bottom: 18.0),
                    child: Center(
                      child: Text(
                        "Starting at: ${model.time}",
                        style: TextStyle(
                          overflow: TextOverflow.fade,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              Get.isDarkMode ? Colors.white60 : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                if (model.note.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 14.0, top: 5, right: 14, bottom: 10),
                    child: SizedBox(
                      height: 55,
                      child: Center(
                        child: Text(
                          model.note.toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? Colors.white60
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                if (showButtons)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 1.0, color: Get.theme.dividerColor),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () => {
                                Get.toNamed(Routes.SERIES_INFO, arguments: {
                                  'season_id': model.seasonId,
                                  'league_id': 0,
                                  'stage_id': model.stageId,
                                  'index': 0,
                                })
                              },
                              child: const Text(
                                "Schedule",
                                textAlign: TextAlign.end,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () => {
                                Get.toNamed(Routes.SERIES_INFO, arguments: {
                                  'season_id': model.seasonId,
                                  'league_id': 0,
                                  'stage_id': model.stageId,
                                  'index': 0,
                                })
                              },
                              child: const Text(
                                "Table",
                                textAlign: TextAlign.end,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
