import 'package:damyo/provider/islogin_provider.dart';
import 'package:damyo/provider/userInfo_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    // 화면 크기를 기반으로 너비와 높이를 동적으로 계산합니다.
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
            width: screenWidth, // 고정 너비 대신 화면 너비 사용
            height: screenHeight, // 고정 높이 대신 화면 높이 사용
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
                // 스크롤 가능하게 변경
                child: Column(// Stack 대신 Column 사용하여 구조 단순화
                    children: [
              const SizedBox(height: 104),
              const Text(
                '간단한 정보를 알려주세요 !',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 87), // 텍스트 사이의 간격 조정
              // 이름 입력
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
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
                    const SizedBox(height: 8), // Text와 TextField 사이 간격 조정
                    TextField(
                      decoration: InputDecoration(
                        hintText: '이름을 입력해주세요.',
                        hintStyle: const TextStyle(
                          color: Color(0xFFA8AFB6),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          // 테두리 추가
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) async {
                        // 이름 입력 시 상태 업데이트
                        Provider.of<UserInfoProvider>(context, listen: false)
                            .setName(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32), // 다음 섹션으로 이동하기 전 간격 추가
              // 나이 입력
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
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
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '나이를 입력해주세요.',
                        hintStyle: const TextStyle(
                          color: Color(0xFFA8AFB6),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        // 나이 입력 시 상태 업데이트
                        Provider.of<UserInfoProvider>(context, listen: false)
                            .setAge(int.parse(value));
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32), // 추가 섹션 전 간격
              // 성별 선택
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
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
                    const SizedBox(height: 8),
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
                                borderRadius: BorderRadius.circular(23),
                                side: selectedGender == '남성'
                                    ? BorderSide.none
                                    : const BorderSide(
                                        color: Color(0xFFEEF1F4), width: 1),
                              ),
                            ),
                            child: const Text('남성'),
                          ),
                        ),
                        const SizedBox(width: 16),
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
                                borderRadius: BorderRadius.circular(23),
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
              const SizedBox(height: 32), // 더 많은 입력 필드를 위한 간격
              // 닉네임 입력
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '닉네임',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '닉네임을 입력해주세요.',
                        hintStyle: const TextStyle(
                          color: Color(0xFFA8AFB6),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        // 닉네임 입력 시 상태 업데이트
                        Provider.of<UserInfoProvider>(context, listen: false)
                            .setNickname(value);
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              //완료 버튼
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                  onPressed: () async {
                    // 받은 정보 서버에 보내기
                    // 마이페이지로 이동
                    Provider.of<IsLoginProvider>(context, listen: false)
                        .checkFirst();
                    context.go('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0099FC),
                    minimumSize: Size(screenWidth, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23),
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
            ]))));
  }
}
