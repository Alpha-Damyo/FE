import 'package:damyo/screens/home/map/ovelay_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class Marker {
  final NInfoOverlayPortalController nOverlayInfoOverlayPortalController;
  final NaverMapController mapController;
  final Stream<void> onCameraChangeStream;

  const Marker({
    required this.nOverlayInfoOverlayPortalController,
    required this.mapController,
    required this.onCameraChangeStream,
  });

  void attachOverlay(String id, double lat, double lng, bool boo) async {
    final cameraPosition = mapController.nowCameraPosition;
    final marker = NMarker(
      id: id,
      position: NLatLng(lat, lng),
    );
    marker.setOnTapListener((overlay) {
      boo = !boo;
      // final latLng = cameraPosition.target;
      // mapController.latLngToScreenLocation(latLng).then((point) =>
      //     addFlutterFloatingOverlay(
      //         point: point, overlay: overlay, latLng: latLng));
    });
    mapController.addOverlay(marker);
  }

  void addFlutterFloatingOverlay({
    required NOverlay<dynamic> overlay,
    required NPoint point,
    required NLatLng latLng,
  }) {
    nOverlayInfoOverlayPortalController.openWithWidget(
        screenPointStream: onCameraChangeStream.asyncMap((event) async =>
            await mapController.latLngToScreenLocation(latLng)),
        builder: (context, mapController, controller, back) {
          Widget header() => Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      overlay.runtimeType.toString(),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    )),
                    InkWell(
                        onTap: back, child: const Icon(Icons.close_rounded)),
                  ]));

          return Column(children: [
            header(),
            Expanded(
                child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    children: [
                  const Text(
                    "에 위치함",
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "zIndex: ${overlay.zIndex} (global: ${overlay.globalZIndex})\n"
                    "${overlay.minZoom} ${overlay.isMinZoomInclusive ? "≤" : "<"}"
                    " [보이는 줌 범위] ${overlay.isMaxZoomInclusive ? "≤" : "<"} ${overlay.maxZoom}\n",
                  ),
                ])),
          ]);
        },
        screenPoint: point,
        overlay: overlay);
  }
}
