class SaInformModel {
  String address;
  String name;
  String? description;
  double latitude;
  double longitude;
  double score;
  bool? opened;
  bool? closed;
  bool? indoor;
  bool? outdoor;
  String? url;

  SaInformModel(
    this.address,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.score,
    this.opened,
    this.closed,
    this.indoor,
    this.outdoor,
    this.url,
  );
}
