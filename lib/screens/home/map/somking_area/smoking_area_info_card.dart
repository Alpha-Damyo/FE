import 'package:damyo/models/smoking_area/sa_basic_model.dart';
import 'package:damyo/screens/home/map/somking_area/add_favorites/add_favorite_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:damyo/database/smoke_database_helper.dart';

class SmokingAreaInfoCard extends StatefulWidget {
  final SaBasicModel saBasicModel;
  const SmokingAreaInfoCard({
    super.key,
    required this.saBasicModel,
  });

  @override
  State<SmokingAreaInfoCard> createState() => _SmokingAreaInfoCardState();
}

class _SmokingAreaInfoCardState extends State<SmokingAreaInfoCard> {
  String get _smokingAreaId => widget.saBasicModel.id;
  String get _smokingAreaName => widget.saBasicModel.name;
  String get _smokingAreaAddress => widget.saBasicModel.address;
  double get _smokingAreaScore => widget.saBasicModel.score;

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
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffd2d7dd)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      Text(" $_smokingAreaName",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  Text("주소: $_smokingAreaAddress"),
                ],
              ),
              // const Text(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rate_rounded,
                            color: Color(0xffffc226),
                          ),
                          Text("$_smokingAreaScore"),
                        ],
                      ),
                      const SizedBox(
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
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddFavoriteBottomSheet(
            saName: _smokingAreaName,
            saId: _smokingAreaId,
          );
        });
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
        onPressed: () async{
          func();
          await smokeDB.insertSmokeInfo(widget.smokingAreaId, widget.smokingAreaName, now);
        },
        child: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ));
  }
}
