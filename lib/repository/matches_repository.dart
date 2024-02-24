import 'package:cricketapp/models/fixture.dart';
import 'package:cricketapp/models/league.dart';
import 'package:cricketapp/models/local_team.dart';
import 'package:cricketapp/models/season.dart';
import 'package:cricketapp/models/stage.dart';
import 'package:cricketapp/models/standing.dart';
import 'package:cricketapp/models/team_ranking.dart';
import 'package:cricketapp/models/team_squad_details.dart';
import 'package:cricketapp/providers/api_client.dart';
import 'package:dio/dio.dart';

class MatchesRepository {
  late final APIClient _apiClient;

  MatchesRepository() {
    _apiClient = APIClient(httpClient: Dio());
  }

  Future<Fixture> getLiveScores(int fixtureId) {
    return _apiClient.getLiveScores(fixtureId);
  }

  Future<List<Fixture>> getAllFixtures({required String startDate, required String endDate, required currentPage}) {
    return _apiClient.getFixtures(startDate: startDate, endDate: endDate, page: currentPage);
  }

  Future<List<Fixture>> getFixturesWithStage({required String startDate, required String endDate}) {
    return _apiClient.getFixturesWithStage(startDate: startDate, endDate: endDate);
  }

  Future<List<Fixture>> getFixturesWithLeague({required String startDate, required String endDate}) {
    return _apiClient.getFixturesWithLeague(startDate: startDate, endDate: endDate);
  }

  Future<List<Fixture>> getFixturesBy({required String filter, required int id}) {
    return _apiClient.getFixturesBy(filterBy: filter, byId: id);
  }

  Future<List<Stage>> getAllStages() {
    return _apiClient.getAllStages();
  }

  Future<Stage> getStageById(int id) {
    return _apiClient.getStageById(stageId: id);
  }

  Future<List<TeamRanking>> getTeamsWithRanking() {
    return _apiClient.getTeamWithRanking();
  }

  Future<List<League>> getAllLeagues() {
    return _apiClient.getLeagues();
  }

  Future<League> getLeagueById(int id) {
    return _apiClient.getLeagueById(leagueId: id);
  }

  Future<Season> getSeasonById(int seasonId) {
    return _apiClient.getSeasonById(seasonId);
  }

  Future<Fixture> getFixtureById(int id) {
    return _apiClient.getFixtureById(id);
  }

  Future<List<Fixture>> getSeasonFixtures(int seriesId) {
    return _apiClient.getSeasonFixtures(seriesId);
  }

  Future<List<Standing>> getStandings(int seasonId) {
    return _apiClient.getStandings(seasonId);
  }

  Future<TeamSquadDetails> getSquadByTeamAndSeasonId(int teamId, int seasonId) {
    return _apiClient.getSquadByTeamAndSeasonId(teamId, seasonId);
  }

  Future<List<LocalTeam>> getAllTeams() {
    return _apiClient.getAllTeams();
  }
}
