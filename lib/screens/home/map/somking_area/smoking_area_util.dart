import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 별점 표시
class SAInfoScreenStar extends StatelessWidget {
  const SAInfoScreenStar({
    super.key,
    required this.starValue,
  });

  final double starValue;

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Colors.yellow),
        Icon(Icons.star, color: Color(0xffe4e7eb)),
      ],
    );
  }
}

// 즐겨찾기, 공유, 내보내기 버튼
class SAInfoScreenBtn extends StatelessWidget {
  const SAInfoScreenBtn({
    super.key,
    required this.context,
    required this.icon,
    required this.name,
    required this.ontap,
  });

  final BuildContext context;
  final IconData icon;
  final String name;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print("tapped");
            ontap();
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).primaryColor),
            child: FittedBox(
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}

// 특징
class SAInfoScreenCharacteristic extends StatelessWidget {
  const SAInfoScreenCharacteristic({
    super.key,
    required this.name,
    required this.count,
  });

  final String name;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: const Color(0xFFD2D7DD)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 8,
              ),
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

List<String> photoUrlList = [
  'https://www.sisain.co.kr/news/photo/202203/47046_84952_2317.jpg',
  'https://mediahub.seoul.go.kr/uploads/mediahub/2023/02/wVVfdlOSDzeCdUziNtMyHjYIvgntUwDm.jpg',
  'https://img1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/user/2OhT/image/bOXhfr9EO2JubQiJKQhI9JqA3xk.jpg',
];

// 사진
class SAInfoScreenPhotos extends StatelessWidget {
  final List<String> photoUrlList;

  const SAInfoScreenPhotos({
    super.key,
    required this.photoUrlList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: photoUrlList.map((url) {
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  url,
                  width: 128,
                  height: 128,
                  fit: BoxFit.fill,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// 영역 구분용 회색 박스
class SAInfoScreenGrayContainer extends StatelessWidget {
  const SAInfoScreenGrayContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 10,
      color: const Color(0xffeef1f5),
    );
  }
}
