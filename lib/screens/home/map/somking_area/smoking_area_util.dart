import 'package:damyo/screens/home/map/somking_area/smoking_area_gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
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
    return Row(
      children: [
        RatingStars(
          starColor: const Color(0xFFFFC226),
          // starSpacing: 4,
          value: starValue,
          maxValueVisibility: false,
          valueLabelVisibility: false,
          starSize: 23,
        ),
        const SizedBox(width: 5),
        Text(
          '($starValue)',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

// 즐겨찾기, 공유, 내보내기 버튼
class SAInfoScreenBtn extends StatefulWidget {
  final BuildContext context;
  final Widget icon;
  final String name;
  final VoidCallback onPressed;

  const SAInfoScreenBtn({
    super.key,
    required this.context,
    required this.icon,
    required this.name,
    required this.onPressed,
  });

  @override
  State<SAInfoScreenBtn> createState() => _SAInfoScreenBtnState();
}

class _SAInfoScreenBtnState extends State<SAInfoScreenBtn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Theme.of(context).primaryColor),
          child: FittedBox(
            child: IconButton(
              onPressed: widget.onPressed,
              icon: widget.icon,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          widget.name,
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
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          for (int i = 0; i < photoUrlList.length; i++)
            Padding(
              padding: EdgeInsets.only(
                  right: i == photoUrlList.length - 1 ? 0 : 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GalleryScreen(photoUrlList, i),
                      ),
                    );
                  },
                  child: Image.network(
                    photoUrlList[i],
                    width: 128,
                    height: 128,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
        ]),
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
