import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChallengeVoteScreen extends StatefulWidget {
  final String title;

  const ChallengeVoteScreen({super.key, required this.title});

  @override
  State<ChallengeVoteScreen> createState() => _ChallengeVoteScreenState();
}

class ImageInfo {
  String url;
  String postDate;
  String location;
  bool isLiked;

  ImageInfo(
      {required this.url,
      required this.postDate,
      required this.location,
      this.isLiked = false});
}

class _ChallengeVoteScreenState extends State<ChallengeVoteScreen> {
  bool isOldestFirst = false;
  bool isGridView = true;
  List<ImageInfo> images = List.generate(
    9,
    (index) => ImageInfo(
      url: "https://via.placeholder.com/128x128?text=Image+${index + 1}",
      postDate: "2023-04-14",
      location: "Location ${index + 1}",
      isLiked: false,
    ),
  );
  List<bool> likes =
      List.filled(9, false); // Initialize like statuses for images

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 667),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('챌린지 투표'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: _refreshImages,
          child: Column(
            children: [
              _buildTopImage(),
              _buildVotingSection(),
              Expanded(
                child: isGridView ? _buildImageGrid() : _buildImageList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshImages() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        images = List.generate(
            12,
            (index) => ImageInfo(
                  url:
                      "https://via.placeholder.com/128x128?text=New+${index + 1}",
                  postDate:
                      "2024-04-14", // Example date, you might want to make this dynamic
                  location: "New Location ${index + 1}",
                  isLiked: false,
                ));
      });
    }
  }

  Widget _buildTopImage() {
    return Container(
      width: 390.w,
      height: 163.h,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://via.placeholder.com/390x163"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildVotingSection() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.title} 투표 ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          _buildSortingOptions(),
        ],
      ),
    );
  }

  Widget _buildSortingOptions() {
    return Row(
      children: [
        InkWell(
          onTap: () => setState(() {
            isOldestFirst = !isOldestFirst;
          }),
          child: Text(
            isOldestFirst ? '인기순' : '최신순',
            style: TextStyle(
              color: const Color(0xFF6E767F),
              fontSize: 12.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        IconButton(
          icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
          color: const Color(0xFF6E767F),
          onPressed: () => setState(() {
            isGridView = !isGridView;
          }),
        ),
      ],
    );
  }

  Widget _buildImageGrid() {
    final screenWidth = MediaQuery.of(context).size.width;
    int gridCount = screenWidth > 600 ? 4 : 3;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridCount,
        childAspectRatio: 1.0,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _buildImageTile(images[index], index);
      },
    );
  }

  Widget _buildImageList() {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _buildImageTileForList(images[index], index);
      },
    );
  }

  Widget _buildImageTile(ImageInfo imageInfo, int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE4E7EA),
        image: DecorationImage(
          image: NetworkImage(imageInfo.url),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          IconButton(
            icon: Icon(
                imageInfo.isLiked ? Icons.favorite : Icons.favorite_border),
            color: imageInfo.isLiked ? Colors.red : Colors.grey,
            onPressed: () {
              setState(() {
                images[index].isLiked = !images[index].isLiked;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageTileForList(ImageInfo imageInfo, int index) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              imageInfo.url,
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    imageInfo.location,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text('Posted on: ${imageInfo.postDate}'),
                ],
              ),
              IconButton(
                icon: Icon(
                    imageInfo.isLiked ? Icons.favorite : Icons.favorite_border),
                color: imageInfo.isLiked ? Colors.red : Colors.grey,
                onPressed: () {
                  setState(() {
                    images[index].isLiked = !images[index].isLiked;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
