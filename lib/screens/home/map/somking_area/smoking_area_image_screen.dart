import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageScreen extends StatelessWidget {
  String? imagePath;

  ImageScreen(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider =
        const AssetImage('assets/images/smoking_area_default_image.png');
    if (imagePath != null) {
      imageProvider = NetworkImage(imagePath!);
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: imageProvider,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2.0,
          enableRotation: false, // 이미지 회전 활성화
        ),
      ),
    );
  }
}
