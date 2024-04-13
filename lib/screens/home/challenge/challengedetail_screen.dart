import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class ChallengeDetailScreen extends StatelessWidget {
  final String title;

  const ChallengeDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('챌린지'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 16,
                    height: 163,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/358x163"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$title : 2024.1.1 ~ 2024.6.30',
                          style: const TextStyle(
                            color: Color(0xFF262B32),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            Share.share(
                                'Check out this challenge: $title running from 2024.1.1 ~ 2024.6.30! Learn more at https://via.placeholder.com/358x163');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Navigate to the ChallengeVoteScreen()
                GoRouter.of(context).push('/vote');
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Container(
                height: 37,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(
                    horizontal: 16), // Adjust margin for full width
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF1F4),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Text(
                  '사진 구경하기',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 360,
              top: 61,
              child: SizedBox(
                width: 12,
                height: 12,
                child: Stack(children: []),
              ),
            ),
            Positioned(
              left: 0,
              top: 376,
              child: Container(
                width: 390,
                height: 624,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/390x624"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
