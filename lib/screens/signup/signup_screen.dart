import 'package:damyo/services/signup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  final String token;
  const SignupScreen({super.key, required this.token});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? selectedGender;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? email;

  @override
  void initState() {
    super.initState();
    _getEmail();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void _getEmail() async {
    email = await storage.read(key: 'userID');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 675),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          foregroundColor: Colors.black,
          title: const Text(''),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 580.h,
            child: Column(
              children: [
                SizedBox(height: 37.h),
                const Expanded(
                  child: Text(
                    '간단한 정보를 알려주세요 !',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 68.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '이름',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: '이름을 입력해주세요.',
                          hintStyle: TextStyle(
                            color: Color(0xFFA8AFB6),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFA9AFB7),
                            ),
                          ),
                        ),
                        onChanged: (value) async {
                          // Provider.of<UserInfoProvider>(context, listen: false)
                          //     .setName(value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 70.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '나이',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            width: 130.w,
                            child: TextField(
                              controller: ageController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: '나이를 입력해주세요.',
                                hintStyle: TextStyle(
                                  color: Color(0xFFA8AFB6),
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFA9AFB7),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                // Provider.of<UserInfoProvider>(context,
                                //         listen: false)
                                //     .setAge(int.parse(value));
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 32.w),
                      SizedBox(
                        width: 154.w,
                        height: 80.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '성별',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 27.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 73.w,
                                  height: 33.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedGender = '남성';
                                        // Provider.of<UserInfoProvider>(context,
                                        //         listen: false)
                                        //     .setGender(true);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xFF6E767F),
                                      backgroundColor: selectedGender == '남성'
                                          ? const Color(0xFF0099FC)
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.r),
                                        side: selectedGender == '남성'
                                            ? BorderSide.none
                                            : const BorderSide(
                                                color: Color(0xFFEEF1F4),
                                                width: 1),
                                      ),
                                    ),
                                    child: const Text('남성',
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                SizedBox(
                                  width: 73.w,
                                  height: 33.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedGender = '여성';
                                        // Provider.of<UserInfoProvider>(context,
                                        //         listen: false)
                                        //     .setGender(false);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color(0xFF6E767F),
                                      backgroundColor: selectedGender == '여성'
                                          ? const Color(0xFF0099FC)
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23.r),
                                        side: selectedGender == '여성'
                                            ? BorderSide.none
                                            : const BorderSide(
                                                color: Color(0xFFEEF1F4),
                                                width: 1),
                                      ),
                                    ),
                                    child: const Text('여성',
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 158.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      // 받은 정보 서버에 보내기
                      // Provider.of<IsLoginProvider>(context, listen: false)
                      //     .checkFirst();
                      Map<String, String> response = await signup(
                        "https://d2wcv86mbz7x2c.cloudfront.net/a4c37b14-2damyo.png",
                        email!,
                        nameController.text,
                        selectedGender!,
                        int.parse(ageController.text),
                        widget.token,
                      );
                      FlutterSecureStorage storage =
                          const FlutterSecureStorage();
                      storage.write(
                          key: "accessToken", value: response['token']);

                      context.go('/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0099FC),
                      minimumSize: Size(390.w, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                    ),
                    child: const Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
