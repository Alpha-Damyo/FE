import 'dart:io';

import 'package:damyo/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damyo/services/profile_update_service.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

XFile? _profileImage;
final ImagePicker picker = ImagePicker();
bool _changedImage = false;

bool _isFieldEmpty(TextEditingController controller) {
  return controller.text.trim().isEmpty;
}

class UpdateprofileScreen extends StatefulWidget {
  const UpdateprofileScreen({super.key});

  @override
  State<UpdateprofileScreen> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<UpdateprofileScreen> {
  final TextEditingController _nameController = TextEditingController();

  // 이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _profileImage = XFile(pickedFile.path);
        _changedImage = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  if (!_isFieldEmpty(_nameController)) {
                    try {
                      String? result =
                          await putUserUpdateName(_nameController.text);
                      context.pop();
                    } catch (e) {
                      _showErrorLog(context, '이름 변경에 실패하셨습니다.');
                    }
                  }
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
                  child: _profileImage == null
                      ? Image.asset(
                          'assets/icons/profile.png',
                          fit: BoxFit.cover,
                        )
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
                      'assets/icons/camera.png',
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

// 애러 메시지 띄우기
void _showErrorLog(BuildContext context, String log) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          // width: 300,
          height: 180,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textFormat(
                          text: log, fontSize: 16, fontWeight: FontWeight.w600),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}