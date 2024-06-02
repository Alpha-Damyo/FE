class SaBasicModel {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final double score;

  SaBasicModel(
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.address,
    this.score,
  );

  SaBasicModel.fromJson(Map<String, dynamic> json)
      : id = json['areaId'],
        name = json['name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        address = json['address'],
        score = json['score'];
}
