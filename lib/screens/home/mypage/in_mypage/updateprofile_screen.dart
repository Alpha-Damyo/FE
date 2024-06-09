import 'dart:io';
import 'package:damyo/models/updateprofile/update_name_model.dart';
import 'package:damyo/models/updateprofile/update_profile_model.dart';
import 'package:damyo/models/userinfo/user_info_model.dart';
import 'package:damyo/screens/home/mypage/mypage_screen.dart';
import 'package:damyo/services/user_controller_service.dart';
import 'package:damyo/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damyo/services/profile_update_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';


String? profileImage;
final ImagePicker picker = ImagePicker();

bool _isFieldEmpty(TextEditingController controller) {
  return controller.text.trim().isEmpty;
}

class UpdateprofileScreen extends StatefulWidget {
  UpdateprofileScreen({super.key, required this.update});
  VoidCallback update;
  @override
  State<UpdateprofileScreen> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<UpdateprofileScreen> {
  final TextEditingController _nameController = TextEditingController();
  XFile? _profileImage;
  bool _changedImage = false;

  // 이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _profileImage = XFile(pickedFile.path);
      });
    }
  }

  // 유저 정보를 가져오는 함수
  Future<UserInfoModel?> getUserprofile() async {
    userInfoModel = await getUserInfo();
    if (userInfoModel != null) {
      setState(() {
        profileImage = userInfoModel.profileUrl;
      });
    } else {
      setState(() {
        profileImage = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserprofile();
    // print(_changedImage);
  }

  @override
  void dispose() {
    _nameController.dispose();
    if (!_changedImage) {
      _profileImage = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    return ScreenUtilInit(
      designSize: const Size(390, 755),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            '프로필 수정',
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () async {
                  String? token = await secureStorage.read(key: 'accessToken');
                  if (_profileImage != null) {
                    String? result2 = await putUserUpdateProfile(
                        UpdateProfileModel.fromMap(_profileImage), token!);
                  }

                  setState(() {
                    _changedImage = true;
                  });
                  if (!_isFieldEmpty(_nameController)) {
                    try {
                      String? result1 = await putUserUpdateName(
                          UpdateNameModel(_nameController.text));
                    } catch (e) {
                      _showErrorLog(context, '중복된 이름입니다.');
                    }
                  }
                  widget.update();
                },
                child: textFormat(
                    text: '완료', fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Stack(children: [
                Container(
                  width: 110,
                  height: 110,
                  padding: const EdgeInsets.only(bottom: 1),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFDEDEDE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ),
                  child: profileImage == null
                      ? Image.asset(
                          'assets/icons/updateprofile_screen/defalut.png')
                      : _profileImage == null
                          ? Image.network(profileImage!)
                          : Image.file(
                              File(_profileImage!.path),
                            ),
                ),
                Positioned(
                  top: 65,
                  left: 65,
                  child: IconButton(
                    onPressed: () async {
                      await getImage(ImageSource.gallery);
                    },
                    icon: Image.asset(
                      'assets/icons/updateprofile_screen/camera.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            '이름',
                            style: TextStyle(
                              color: Color(0xFF262B32),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFE4E7EA)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: TextField(
                            controller: _nameController,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> _showErrorLog(BuildContext context, String log) {
  return showModalBottomSheet(
      context: context,
      builder: (dialog) {
        return Container(
          width: 390,
          height: 170,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 43.0, bottom: 36.0),
                child: textFormat(
                    text: log, fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0099FC),
                      fixedSize: const Size(350, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(dialog).pop();
                    },
                    child: textFormat(
                        text: '닫기',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
