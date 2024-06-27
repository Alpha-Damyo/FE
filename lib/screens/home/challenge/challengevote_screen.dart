import 'package:damyo/models/contest_model.dart';
import 'package:damyo/services/contest_like_service.dart';
import 'package:damyo/services/contest_page_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class ChallengeVoteScreen extends StatefulWidget {
  final String title;

  const ChallengeVoteScreen({super.key, required this.title});

  @override
  State<ChallengeVoteScreen> createState() => _ChallengeVoteScreenState();
}

class _ChallengeVoteScreenState extends State<ChallengeVoteScreen> {
  bool sortDate = true;
  bool isGridView = true;
  List<Picture> images = [];

  FlutterSecureStorage storage = const FlutterSecureStorage();

  int cursorId = 1;
  String? token = '';
  String sortBy = '2024-06-09';
  String? region;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    try {
      token = await storage.read(key: 'accessToken');
      sortBy = sortDate ? 'date' : 'like';
      ContestResponse contestResponse =
          await contestPage(token!, cursorId, sortBy);

      print(contestResponse.pictureList);
      setState(() {
        images = contestResponse.pictureList;
      });
    } catch (error) {
      // Handle error
      print('Error fetching images: $error');
      setState(() {});
    }
  }

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
          onRefresh: _fetchImages,
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

  void updateImageInfo(Picture updatedInfo) {
    setState(() {
      final index =
          images.indexWhere((element) => element.id == updatedInfo.id);
      if (index != -1) {
        images[index] = updatedInfo;
      }
    });
  }

  Widget _buildTopImage() {
    return SizedBox(
      width: 390.w,
      height: 163.h,
      child: Image.asset('assets/images/challenge_thumbnail.png'),
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/images/challenge_thumbnail.png"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
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
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
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
            sortDate = !sortDate;
            _fetchImages();
          }),
          child: Text(
            sortDate ? '최신순' : '인기순',
            style: const TextStyle(
              color: Color(0xFF6E767F),
              fontSize: 12,
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
        return _buildImageTile(images[index]);
      },
    );
  }

  Widget _buildImageList() {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _buildImageTileForList(images[index]);
      },
    );
  }

  Widget _buildImageTile(Picture imageInfo) {
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
            image: NetworkImage(imageInfo.pictureUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            // IconButton(
            //   icon: Icon(
            //       imageInfo.likeCheck ? Icons.favorite : Icons.favorite_border),
            //   color: imageInfo.likeCheck ? Colors.red : Colors.grey,
            //   onPressed: () {
            //     setState(() {
            //       imageInfo.likeCheck = !imageInfo.likeCheck;
            //       if (imageInfo.likeCheck) {
            //         contestLike(token, imageInfo.id);
            //       } else {
            //         contestUnlike(token, imageInfo.id);
            //       }
            //     });
            //   },
            // ),
            LikeButton(
              imageInfo: imageInfo,
              token: token!,
              onLikeChanged: (isLiked) {
                updateImageInfo(imageInfo);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageTileForList(Picture imageInfo) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

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
            imageInfo.pictureUrl,
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
                  imageInfo.id
                      .toString(), // Display the ID for now, change as needed
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                    '게시일: ${dateFormat.format(imageInfo.createdAt).toString()}'), // Format the date as needed
              ],
            ),
            const Spacer(),
            // IconButton(
            //   icon: Icon(
            //       imageInfo.likeCheck ? Icons.favorite : Icons.favorite_border),
            //   color: imageInfo.likeCheck ? Colors.red : Colors.grey,
            //   onPressed: () {
            //     setState(() {
            //       imageInfo.likeCheck = !imageInfo.likeCheck;
            //     });
            //   },
            // ),
            LikeButton(
              imageInfo: imageInfo,
              token: token!,
              onLikeChanged: (isLiked) {
                updateImageInfo(imageInfo);
              },
            ),
          ],
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildImageDetailDialog(Picture imageInfo) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return ScreenUtilInit(
          designSize: const Size(360, 650),
          builder: (context, child) => Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 350.w,
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
                          const Text(
                            '하동이',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageInfo.pictureUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      // IconButton(
                      //   icon: Icon(imageInfo.likeCheck
                      //       ? Icons.favorite
                      //       : Icons.favorite_border),
                      //   color: imageInfo.likeCheck ? Colors.red : Colors.grey,
                      //   onPressed: () {
                      //     setState(() {
                      //       imageInfo.likeCheck = !imageInfo.likeCheck;
                      //     });
                      //     updateImageInfo(imageInfo);
                      //   },
                      // ),
                      LikeButton(
                        imageInfo: imageInfo,
                        token: token!,
                        onLikeChanged: (isLiked) {
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
                      '게시일 : ${dateFormat.format(imageInfo.createdAt).toString()}', // Format the date as needed
                      style: const TextStyle(
                        color: Color(0xFF33383E),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '장소 : ${imageInfo.id}', // Use appropriate field for location if available
                      style: const TextStyle(
                        color: Color(0xFF33383E),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
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

class LikeButton extends StatefulWidget {
  final Picture imageInfo;
  final String token;
  final Function(bool) onLikeChanged;

  const LikeButton({
    super.key,
    required this.imageInfo,
    required this.token,
    required this.onLikeChanged,
  });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.imageInfo.likeCheck;
  }

  @override
  void didUpdateWidget(LikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update local isLiked state if imageInfo's likeCheck has changed
    if (widget.imageInfo.likeCheck != oldWidget.imageInfo.likeCheck) {
      setState(() {
        isLiked = widget.imageInfo.likeCheck;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
      ),
      color: isLiked ? Colors.red : Colors.grey,
      onPressed: () {
        // Toggle like status
        final bool newLikeStatus = !isLiked;

        // Update like status locally
        setState(() {
          isLiked = newLikeStatus;
        });

        // Call service to update like status in backend
        widget.onLikeChanged(newLikeStatus);
        if (newLikeStatus) {
          contestLike(widget.token, widget.imageInfo.id);
        } else {
          contestUnlike(widget.token, widget.imageInfo.id);
        }
      },
    );
  }
}
