import 'package:cricketapp/modules/favourite/teams_binding.dart';
import 'package:cricketapp/modules/favourite/teams_view.dart';
import 'package:cricketapp/modules/match-details-live/live-balls/live_balls_binding.dart';
import 'package:cricketapp/modules/match-details-live/live-balls/live_balls_view.dart';
import 'package:cricketapp/modules/match-details-live/match_details_binding.dart';
import 'package:cricketapp/modules/match-details-live/match_details_view.dart';
import 'package:cricketapp/modules/news/bindings/news_details_binding.dart';
import 'package:cricketapp/modules/news/views/news_details_view.dart';
import 'package:cricketapp/modules/player-ranking/player_ranking_binding.dart';
import 'package:cricketapp/modules/player-ranking/player_ranking_view.dart';
import 'package:cricketapp/modules/root/binding/root_binding.dart';
import 'package:cricketapp/modules/root/view/root_view.dart';
import 'package:cricketapp/modules/series-info/series_info_binding.dart';
import 'package:cricketapp/modules/series-info/series_info_view.dart';
import 'package:cricketapp/modules/splash_screen.dart';
import 'package:cricketapp/modules/squad/squad_binding.dart';
import 'package:cricketapp/modules/squad/squad_view.dart';
import 'package:cricketapp/modules/topranking/top_ranking_binding.dart';
import 'package:cricketapp/modules/topranking/top_ranking_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initialRoute = Routes.ROOT;

  static final routes = [
    GetPage(name: Routes.ROOT, page: () => const RootView(), binding: RootBinding()),
    GetPage(name: Routes.SERIES_INFO, page: () => const SeriesInfoView(), binding: SeriesInfoBindings()),
    GetPage(name: Routes.SQUAD_INFO, page: () => const SquadView(), binding: SquadBindings()),
    GetPage(name: Routes.MATCH_INFO, page: () => const MatchDetailsView(), binding: MatchDetailsBinding()),
    GetPage(name: Routes.FAVOURITE, page: () => const TeamsView(), binding: TeamsBindings()),
    GetPage(name: Routes.NEWS_DETAILS, page: () => const NewsDetailsView(), binding: NewsDetailsBinding()),
    GetPage(name: Routes.TEAM_RANKING, page: () => const TopRankingView(), binding: TopRankingBindings()),
    GetPage(name: Routes.PLAYER_RANKING, page: () => const PlayerRankingView(), binding: PlayerRankingBindings()),
    GetPage(name: Routes.LIVE_BALLS, page: () => const LiveBallsView(), binding: LiveBallsBindings()),
    GetPage(name: Routes.SPLASH_SCREEN, page: () => const SplashScreen()),
  ];
}
