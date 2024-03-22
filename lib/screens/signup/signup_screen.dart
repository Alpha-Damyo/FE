import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  //이름, 이메일, 성별, 프로필 사진 입력
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: Column(
        children: [
          const Text('이름'),
          const TextField(),
          const Text('이메일'),
          const TextField(),
          const Text('성별'),
          const TextField(),
          const Text('프로필 사진'),
          ElevatedButton(
            onPressed: () {
              //프로필 사진 선택
            },
            child: const Text('사진 선택'),
          ),
          ElevatedButton(
            onPressed: () {
              //회원가입 완료
              context.pop();
            },
            child: const Text('회원가입'),
          ),
        ],
      ),
    );
  }
}
