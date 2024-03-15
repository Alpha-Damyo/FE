import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '마이페이지 들어갈 페이지',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        IconButton(
            onPressed: () {
              context.push('/login');
            },
            icon: const Icon(Icons.login)),
      ],
    );
  }
}
