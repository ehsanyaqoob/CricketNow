import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/models/league.dart';
import 'package:cricketapp/models/local_team.dart';
import 'package:cricketapp/models/season.dart';
import 'package:cricketapp/models/stage.dart';
import 'package:cricketapp/models/standing.dart';
import 'package:cricketapp/models/team_ranking.dart';
import 'package:cricketapp/models/team_squad_details.dart';
import 'package:cricketapp/providers/end_points.dart';
import 'package:dio/dio.dart' as diodart;

class APIClient {
  final diodart.Dio httpClient;

  APIClient({required this.httpClient});

  Future<Fixture> getLiveScores(int fixtureId) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.LIVE_SCORES}/$fixtureId", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': 'balls,visitorTeam,runs,localTeam,venue,batting.batsman,bowling.bowler',
    });
    if (response.statusCode == 200) {
      return Fixture.fromJson(response.data['data']);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Fixture>> getFixturesWithStage({required String startDate, required String endDate}) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.FIXTURES}", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': 'stage',
      'filter[starts_between]': "$startDate,$endDate",
    });
    if (response.statusCode == 200) {
      return response.data['data'].map<Fixture>((e) => Fixture.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Fixture>> getFixturesBy({required String filterBy, required int byId}) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.FIXTURES}", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': 'stage,visitorTeam,runs,localTeam,venue',
      'filter[$filterBy]': byId,
    });
    if (response.statusCode == 200) {
      return response.data['data'].map<Fixture>((e) => Fixture.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Fixture>> getFixturesWithLeague({required String startDate, required String endDate}) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.FIXTURES}", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': 'league',
      'filter[starts_between]': "$startDate,$endDate",
    });
    if (response.statusCode == 200) {
      return response.data['data'].map<Fixture>((e) => Fixture.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Stage>> getAllStages() async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.STAGES}", queryParameters: {'api_token': EndPoints.API_TOKEN, 'include': ''});
    if (response.statusCode == 200) {
      return response.data['data'].map<Stage>((e) => Stage.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<Stage> getStageById({required int stageId}) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.STAGES}/$stageId", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': '',
    });
    if (response.statusCode == 200) {
      return Stage.fromJson(response.data['data']);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<League>> getLeagues() async {
    var response = await httpClient.get(
      "${EndPoints.BASE_URL}${EndPoints.LEAGUES}",
      queryParameters: {'api_token': EndPoints.API_TOKEN, 'include': ''},
    );
    if (response.statusCode == 200) {
      return response.data['data'].map<League>((e) => League.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<TeamRanking>> getTeamWithRanking() async {
    var response = await httpClient.get(
      "${EndPoints.BASE_URL}${EndPoints.TEAM_RANKING}",
      queryParameters: {'api_token': EndPoints.API_TOKEN, 'include': ''},
    );
    if (response.statusCode == 200) {
      return response.data['data'].map<TeamRanking>((e) => TeamRanking.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<League> getLeagueById({required int leagueId}) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.LEAGUES}/$leagueId", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': '',
    });
    if (response.statusCode == 200) {
      return League.fromJson(response.data['data']);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<Season> getSeasonById(int id) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.SEASONS}/$id", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': 'league,stages',
    });
    if (response.statusCode == 200) {
      return Season.fromJson(response.data['data']);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Fixture>> getSeasonFixtures(int stageId) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.FIXTURES}", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': 'visitorTeam,runs,localTeam,venue,batting.batsman,bowling.bowler',
      'filter[season_id]': stageId
    });
    if (response.statusCode == 200) {
      return response.data['data'].map<Fixture>((e) => Fixture.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Standing>> getStandings(int seasonId) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.STANDINGS}/${EndPoints.SEASON}/$seasonId", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': '',
    });
    if (response.statusCode == 200) {
      return response.data['data'].map<Standing>((e) => Standing.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<Fixture>> getFixtures({required String startDate, required String endDate, required int page}) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.FIXTURES}", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': 'visitorTeam,runs,localTeam,venue,stage',
      'filter[starts_between]': "$startDate,$endDate",
    });
    if (response.statusCode == 200) {
      return response.data['data'].map<Fixture>((e) => Fixture.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<Fixture> getFixtureById(int id) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.FIXTURES}/$id", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': 'balls,visitorTeam,runs,localTeam,venue,batting.batsman,bowling.bowler,stage',
    });
    if (response.statusCode == 200) {
      return Fixture.fromJson(response.data['data']);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<TeamSquadDetails> getSquadByTeamAndSeasonId(int teamId, int seasonId) async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.TEAMS}/$teamId/${EndPoints.SQUAD}/$seasonId", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': '',
    });
    if (response.statusCode == 200) {
      return TeamSquadDetails.fromJson(response.data['data']);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<List<LocalTeam>> getAllTeams() async {
    var response = await httpClient.get("${EndPoints.BASE_URL}${EndPoints.TEAMS}", queryParameters: {
      'api_token': EndPoints.API_TOKEN,
      'include': '',
    });
    if (response.statusCode == 200) {
      return response.data['data'].map<LocalTeam>((e) => LocalTeam.fromJson(e)).toList();
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
