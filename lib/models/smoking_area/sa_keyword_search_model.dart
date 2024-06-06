class SaKeywordSearchModel {
  String keyword;
  bool? status;
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

  SaKeywordSearchModel.fromMap(String input, Map<String, dynamic> data)
      : keyword = input,
        status = data['satatus'],
        opened = data['opened'],
        closed = data['opened'],
        hygiene = data['hygiene'],
        dirty = data['dirty'],
        airOut = data['airOut'],
        noExist = data['noExist'],
        indoor = data['indoor'],
        outdoor = data['outdoor'],
        big = data['big'],
        small = data['small'],
        crowded = data['crowded'],
        quite = data['quite'],
        chair = data['chair'];

  Map<String, dynamic> toMap() {
    return {
      "word": keyword,
      "status": status,
      "opened": opened,
      "closed": closed,
      "hygiene": hygiene,
      "dirty": dirty,
      "airOut": airOut,
      "noExist": noExist,
      "indoor": indoor,
      "outdoor": outdoor,
      "big": big,
      "small": small,
      "crowded": crowded,
      "quite": quite,
      "chair": chair,
    };
  }
}
