import 'package:share_plus/share_plus.dart';

class UpdateProfileModel {
  final String name;
  final String path;

  UpdateProfileModel(this.name, this.path);

  UpdateProfileModel.fromMap(XFile? _xfile)
    : name = _xfile!.name,
      path = _xfile.path;

  @override
  String toString() {
    return 'name: $name, path: $path';
  }
}
