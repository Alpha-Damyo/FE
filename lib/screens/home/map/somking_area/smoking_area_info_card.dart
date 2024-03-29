import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SmokingAreaInfoCard extends StatefulWidget {
  final String smokingAreaId;
  const SmokingAreaInfoCard({
    super.key,
    required this.smokingAreaId,
  });

  @override
  State<SmokingAreaInfoCard> createState() => _SmokingAreaInfoCardState();
}

class _SmokingAreaInfoCardState extends State<SmokingAreaInfoCard> {
  String get _smokingAreaId => widget.smokingAreaId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/sa_info', extra: _smokingAreaId);
      },
      child: Container(
        // Todo: _smokingAreaId를 통해 흡연구역 정보를 불러와야함
        alignment: Alignment.center,
        height: 180,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffd2d7dd)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_sharp),
                      Text(" 국민대 도서관 $_smokingAreaId",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  const Text("상세주소: 서울특별시 성북구 정릉로 77"),
                ],
              ),
              // const Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            color: Color(0xffffc226),
                          ),
                          Text("3.7"),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SmokingAreaInfoCardBtn(context, '즐겨찾기 추가', addFavorites),
                      const SizedBox(width: 10),
                      SmokingAreaInfoCardBtn(context, '흡연 완료', completeSmoking),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void addFavorites() {
    print("add favorites");
  }

  void completeSmoking() {
    print("complete smoking");
  }

  ElevatedButton SmokingAreaInfoCardBtn(
      BuildContext context, String name, void Function() func) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(35, 35),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          func();
        },
        child: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
