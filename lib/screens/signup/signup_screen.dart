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
                Expanded(
                  child: Text(
                    '간단한 정보를 알려주세요 !',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
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
                          enabledBorder: const UnderlineInputBorder(),
                        ),
                        onChanged: (value) async {
                          Provider.of<UserInfoProvider>(context, listen: false)
                              .setName(value);
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
                          SizedBox(
                            width: 130.w,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '나이를 입력해주세요.',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFA8AFB6),
                                  fontSize: 14.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                                enabledBorder: const UnderlineInputBorder(),
                              ),
                              onChanged: (value) {
                                Provider.of<UserInfoProvider>(context,
                                        listen: false)
                                    .setAge(int.parse(value));
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
                            Text(
                              '성별',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
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
                                        borderRadius:
                                            BorderRadius.circular(23.r),
                                        side: selectedGender == '남성'
                                            ? BorderSide.none
                                            : const BorderSide(
                                                color: Color(0xFFEEF1F4),
                                                width: 1),
                                      ),
                                    ),
                                    child: Text('남성',
                                        style: TextStyle(fontSize: 14.sp)),
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
                                        borderRadius:
                                            BorderRadius.circular(23.r),
                                        side: selectedGender == '여성'
                                            ? BorderSide.none
                                            : const BorderSide(
                                                color: Color(0xFFEEF1F4),
                                                width: 1),
                                      ),
                                    ),
                                    child: Text('여성',
                                        style: TextStyle(fontSize: 14.sp)),
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
