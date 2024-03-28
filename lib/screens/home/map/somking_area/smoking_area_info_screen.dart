import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SmokingAreaInfoScreen extends StatefulWidget {
  const SmokingAreaInfoScreen({super.key});

  @override
  State<SmokingAreaInfoScreen> createState() => _SmokingAreaInfoScreenState();
}

class _SmokingAreaInfoScreenState extends State<SmokingAreaInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final String smokingAreaId = GoRouterState.of(context).extra! as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '국민대 도서관 $smokingAreaId',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ")),
    );
  }
}
