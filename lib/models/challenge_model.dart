class Challenge {
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  final String bannerImgUrl;
  final String detailImgUrl;

  Challenge({
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.bannerImgUrl,
    required this.detailImgUrl,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      name: json['name'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      bannerImgUrl: json['bannerImgUrl'],
      detailImgUrl: json['detailImgUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'bannerImgUrl': bannerImgUrl,
      'detailImgUrl': detailImgUrl,
    };
  }
}
