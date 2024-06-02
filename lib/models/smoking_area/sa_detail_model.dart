class SaDetailModel {
  String id;
  String name;
  double latitude;
  double longitude;
  String address;
  String creadtedAt;
  bool? status;
  String description;
  double score;
  bool? opened;
  bool? closed;
  bool? hygiene;
  bool? dirty;
  bool? airOut;
  bool? noExist;
  bool? indoor;
  bool? outdoor;
  bool? big;
  bool? small;
  bool? crowded;
  bool? quite;
  bool? chair;

  SaDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['areaId'],
        name = json['name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        address = json['address'],
        creadtedAt = json['createdAt'],
        description = json['description'],
        score = json['score'],
        opened = json['opened'],
        closed = json['closed'],
        hygiene = json['hygiene'],
        dirty = json['dirty'],
        airOut = json['air_out'],
        noExist = json['no_exist'],
        indoor = json['indoor'],
        outdoor = json['outdoor'],
        big = json['big'],
        small = json['small'],
        crowded = json['crowded'],
        quite = json['quite'],
        chair = json['chair'];
}
