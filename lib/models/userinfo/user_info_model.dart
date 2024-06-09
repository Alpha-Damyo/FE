class UserInfoModel {
  String? id;
  String? name;
  String? email;
  String? createAt;
  String? profileUrl;
  int? contribution;
  String? gender;
  int? age;
  double? percentage;
  int? gap;
  String? provider;
  String? providerId;

  UserInfoModel(
      this.id,
      this.name,
      this.email,
      this.createAt,
      this.profileUrl,
      this.contribution,
      this.gender,
      this.age,
      this.percentage,
      this.gap,
      this.provider,
      this.providerId);

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        createAt = json['createAt'],
        profileUrl = json['profileUrl'],
        contribution = json['cotribution'],
        gender = json['gender'],
        age = json['age'],
        percentage = json['percentage'],
        gap = json['gap'],
        provider = json['provider'],
        providerId = json['providerId'];

  @override
  String toString() {
    return '$profileUrl, $name';
  }
}
