class TeamDlData {
  late String score;
  late String overs;
  late String wicketsOut;
  late String rpcOvers;
  late String rpcTargets;
  late String totalOversPlayed;

  TeamDlData() {
    score = "0";
    overs = "0";
    wicketsOut = "0";
    rpcOvers = "0";
    rpcTargets = "0";
    totalOversPlayed = "0";
  }

  TeamDlData.fromJson(Map<String, dynamic> json) {
    score = json['score'] ?? "0";
    overs = json['overs'] ?? "0";
    wicketsOut = json['wickets_out'] ?? "0";
    rpcOvers = json['rpc_overs'] ?? "0";
    rpcTargets = json['rpc_targets'] ?? "0";
  }
}
