class ImageModel {
  int id;
  String picutreUrl;
  String createdAt;
  int likes;

  ImageModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        picutreUrl = json['pictureUrl'],
        createdAt = json['createdAt'],
        likes = json['likes'];
}
