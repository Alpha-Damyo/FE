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
  List<bool> likes = List.filled(9, false);

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
          scrolledUnderElevation: 0,
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

  void updateImageInfo(ImageInfo updatedInfo) {
    setState(() {
      final index =
          images.indexWhere((element) => element.url == updatedInfo.url);
      if (index != -1) {
        images[index] = updatedInfo;
      }
    });
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 15.w),
          Text(
            '${widget.title} 투표 ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
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
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              insetPadding: EdgeInsets.all(15.w),
              content: _buildImageDetailDialog(imageInfo),
            );
          },
        );
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildImageTileForList(ImageInfo imageInfo, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.transparent,
                  insetPadding: EdgeInsets.all(15.w),
                  content: _buildImageDetailDialog(imageInfo),
                );
              },
            );
          },
          child: Image.network(
            imageInfo.url,
            width: 390.w,
            height: 200.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  imageInfo.location,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text('게시일: ${imageInfo.postDate}'),
              ],
            ),
            const Spacer(),
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
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildImageDetailDialog(ImageInfo imageInfo) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ScreenUtilInit(
          designSize: const Size(360, 700),
          builder: (context, child) => Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 350.w,
                color: Colors.white,
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFDEDEDE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 33.w,
                                  height: 27.h,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://via.placeholder.com/33x33"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '하동이',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: 360.w,
                height: 450.h,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Color(0xFF636363)),
                child: Container(
                  width: 393.w,
                  height: 523.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage("https://via.placeholder.com/360x450"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      IconButton(
                        icon: Icon(imageInfo.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: imageInfo.isLiked ? Colors.red : Colors.grey,
                        onPressed: () {
                          setState(() {
                            imageInfo.isLiked = !imageInfo.isLiked;
                          });
                          updateImageInfo(imageInfo);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '게시일 : ${imageInfo.postDate}',
                      style: TextStyle(
                        color: const Color(0xFF33383E),
                        fontSize: 12.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '장소 : ${imageInfo.location}',
                      style: TextStyle(
                        color: const Color(0xFF33383E),
                        fontSize: 12.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
