class ContestResponse {
  final int? lastCursorId;
  final bool? hasNext;
  final List<Picture> pictureList;

  ContestResponse({
    required this.lastCursorId,
    required this.hasNext,
    required this.pictureList,
  });

  factory ContestResponse.fromJson(Map<String, dynamic> json) {
    var pictureListFromJson = json['pictureList'] as List;
    List<Picture> pictureList = pictureListFromJson
        .map((pictureJson) => Picture.fromJson(pictureJson))
        .toList();

    return ContestResponse(
      lastCursorId: json['lastCursorId'],
      hasNext: json['hasNext'],
      pictureList: pictureList,
    );
  }
}

class Picture {
  final int id;
  final String pictureUrl;
  final DateTime createdAt;
  final int likes;
  late final bool likeCheck;

  Picture({
    required this.id,
    required this.pictureUrl,
    required this.createdAt,
    required this.likes,
    required this.likeCheck,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      id: json['id'],
      pictureUrl: json['pictureUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      likes: json['likes'],
      likeCheck: json['likeCheck'],
    );
  }
}
