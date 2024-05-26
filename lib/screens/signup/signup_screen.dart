import 'package:damyo/provider/islogin_provider.dart';
import 'package:damyo/provider/userInfo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 667),
      builder: (context, child) => Scaffold(
        body: Container(
          width: 390.w,
          height: 667.h,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 104.h),
                Text(
                  '간단한 정보를 알려주세요 !',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 68.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '이름',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '이름을 입력해주세요.',
                          hintStyle: TextStyle(
                            color: const Color(0xFFA8AFB6),
                            fontSize: 14.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onChanged: (value) async {
                          Provider.of<UserInfoProvider>(context, listen: false)
                              .setName(value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '나이',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '나이를 입력해주세요.',
                          hintStyle: TextStyle(
                            color: const Color(0xFFA8AFB6),
                            fontSize: 14.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onChanged: (value) {
                          Provider.of<UserInfoProvider>(context, listen: false)
                              .setAge(int.parse(value));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '성별',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedGender = '남성';
                                  Provider.of<UserInfoProvider>(context,
                                          listen: false)
                                      .setGender(true);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF6E767F),
                                backgroundColor: selectedGender == '남성'
                                    ? const Color(0xFF0099FC)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23.r),
                                  side: selectedGender == '남성'
                                      ? BorderSide.none
                                      : const BorderSide(
                                          color: Color(0xFFEEF1F4), width: 1),
                                ),
                              ),
                              child: const Text('남성'),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedGender = '여성';
                                  Provider.of<UserInfoProvider>(context,
                                          listen: false)
                                      .setGender(false);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF6E767F),
                                backgroundColor: selectedGender == '여성'
                                    ? const Color(0xFF0099FC)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(23.r),
                                  side: selectedGender == '여성'
                                      ? BorderSide.none
                                      : const BorderSide(
                                          color: Color(0xFFEEF1F4), width: 1),
                                ),
                              ),
                              child: const Text('여성'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 32.w),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         '닉네임',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 16.sp,
                //           fontFamily: 'Pretendard',
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       SizedBox(height: 8.h),
                //       TextField(
                //         decoration: InputDecoration(
                //           hintText: '닉네임을 입력해주세요.',
                //           hintStyle: TextStyle(
                //             color: const Color(0xFFA8AFB6),
                //             fontSize: 14.sp,
                //             fontFamily: 'Pretendard',
                //             fontWeight: FontWeight.w500,
                //           ),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(8.r),
                //           ),
                //         ),
                //         onChanged: (value) {
                //           Provider.of<UserInfoProvider>(context, listen: false)
                //               .setNickname(value);
                //         },
                //       ),
                //       SizedBox(height: 8.h),
                //     ],
                //   ),
                // ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: ElevatedButton(
                    onPressed: () async {
                      // 받은 정보 서버에 보내기
                      Provider.of<IsLoginProvider>(context, listen: false)
                          .checkFirst();
                      context.go('/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0099FC),
                      minimumSize: Size(390.w, 48.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                    ),
                    child: Text(
                      '완료',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
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
