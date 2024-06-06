class SaReivewModel {
  String id;
  double score;
  bool? opened;
  bool? closed;
  bool? notExist;
  bool? airOut;
  bool? hygiene;
  bool? dirty;
  bool? indoor;
  bool? outdoor;
  bool? big;
  bool? small;
  bool? crowded;
  bool? quite;
  bool? chair;
  String? url;

  SaReivewModel(
      {required this.id,
      required this.score,
      required this.opened,
      required this.closed,
      required this.notExist,
      required this.airOut,
      required this.hygiene,
      required this.dirty,
      required this.indoor,
      required this.outdoor,
      required this.big,
      required this.small,
      required this.crowded,
      required this.quite,
      required this.chair,
      required this.url});

  SaReivewModel.fromJson(Map<String, dynamic> json)
      : id = json['areaId'],
        score = json['score'],
        opened = json['opened'],
        closed = json['closed'],
        hygiene = json['hygiene'],
        dirty = json['dirty'],
        airOut = json['air_out'],
        notExist = json['no_exist'],
        indoor = json['indoor'],
        outdoor = json['outdoor'],
        big = json['big'],
        small = json['small'],
        crowded = json['crowded'],
        quite = json['quite'],
        chair = json['chair'];

  Map<String, dynamic> toJson() {
    return {
      "smokingAreaId": id,
      "score": score,
      "opened": opened,
      "closed": closed,
      "notExist": notExist,
      "airOut": airOut,
      "hygiene": hygiene,
      "dirty": dirty,
      "indoor": indoor,
      "outdoor": outdoor,
      "big": big,
      "small": small,
      "crowded": crowded,
      "quite": quite,
      "chair": chair,
      "url": "string"
    };
  }
}
