class RankResponse {
  List<User> topRankResponse;
  List<User> nearRankResponse;

  RankResponse({
    required this.topRankResponse,
    required this.nearRankResponse,
  });

  factory RankResponse.fromJson(Map<String, dynamic> json) {
    return RankResponse(
      topRankResponse:
          List<User>.from(json['topRankResponse'].map((x) => User.fromJson(x))),
      nearRankResponse: List<User>.from(
          json['nearRankResponse'].map((x) => User.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topRankResponse':
          List<dynamic>.from(topRankResponse.map((x) => x.toJson())),
      'nearRankResponse':
          List<dynamic>.from(nearRankResponse.map((x) => x.toJson())),
    };
  }
}

class User {
  String userId;
  String name;
  String? profileUrl;
  int? likeCount;
  int ranking;

  User({
    required this.userId,
    required this.name,
    this.profileUrl,
    this.likeCount,
    required this.ranking,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      profileUrl: json['profileUrl'],
      likeCount: json['likeCount'],
      ranking: json['ranking'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'profileUrl': profileUrl,
      'likeCount': likeCount,
      'ranking': ranking,
    };
  }
}
