import 'package:damyo/models/challenge_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final Challenge challenge;
  const ChallengeDetailScreen({super.key, required this.challenge});

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 667),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('챌린지'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: 390.w,
                    height: 163.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.challenge.bannerImgUrl),
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.challenge.name} : ${widget.challenge.startTime.toString().substring(0, 10)} ~ ${widget.challenge.endTime.toString().substring(0, 10)}',
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
                                'Check out this challenge: ${widget.challenge.name} running from 2024.1.1 ~ 2024.6.30! Learn more at https://via.placeholder.com/358x163');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  GoRouter.of(context)
                      .push('/vote', extra: {'title': widget.challenge.name});
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Container(
                  height: 37.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF1F4),
                    borderRadius: BorderRadius.circular(22.r),
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
              SizedBox(height: 12.h),
              Container(
                width: 390.w,
                height: 624.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/challenge.png"),
                    fit: BoxFit.fill,
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
