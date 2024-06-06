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
  int openedCount;
  bool? closed;
  int closedCount;
  bool? hygiene;
  int hygieneCount;
  bool? dirty;
  int dirtyCount;
  bool? airOut;
  int airOutCount;
  bool? noExist;
  int noExistCount;
  bool? indoor;
  int indoorCount;
  bool? outdoor;
  int outdoorCount;
  bool? big;
  int bigCount;
  bool? small;
  int smallCount;
  bool? crowded;
  int crowdedCount;
  bool? quite;
  int quiteCount;
  bool? chair;
  int chairCount;
  List<dynamic> pictureList;

  SaDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['areaId'],
        name = json['name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        address = json['address'],
        creadtedAt = json['createdAt'],
        status = json['status'],
        description = json['description'],
        score = json['score'],
        opened = json['opened'],
        openedCount = json['openedCount'],
        closed = json['closed'],
        closedCount = json['closedCount'],
        hygiene = json['hygiene'],
        hygieneCount = json['hygieneCount'],
        dirty = json['dirty'],
        dirtyCount = json['dirtyCount'],
        airOut = json['air_out'],
        airOutCount = json['airOutCount'],
        noExist = json['no_exist'],
        noExistCount = json['noExistCount'],
        indoor = json['indoor'],
        indoorCount = json['indoorCount'],
        outdoor = json['outdoor'],
        outdoorCount = json['outdoorCount'],
        big = json['big'],
        bigCount = json['bigCount'],
        small = json['small'],
        smallCount = json['smallCount'],
        crowded = json['crowded'],
        crowdedCount = json['crowdedCount'],
        quite = json['quite'],
        quiteCount = json['quiteCount'],
        chair = json['chair'],
        chairCount = json['chairCount'],
        pictureList = json['pictureList'];
}
