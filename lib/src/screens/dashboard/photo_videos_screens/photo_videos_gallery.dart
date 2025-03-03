import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/layouts/dashboard_layout.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/images/swipable_image_fullscreen.dart';
import 'package:nb_utils/nb_utils.dart';

String _week = 'week';
String _category = 'category';
String _other = 'other';

class PhotoVideosGallery extends StatefulWidget {
  const PhotoVideosGallery({super.key});

  @override
  State<PhotoVideosGallery> createState() => _PhotoVideosGalleryState();
}

class _PhotoVideosGalleryState extends State<PhotoVideosGallery> {
  String currentCategory = _category;
  void setCurrentCategory(String category) {
    print('setCurrentCategory: $category');
    setState(() {
      currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> _images = List.generate(
        50,
        (index) =>
            placeholderImages[Random().nextInt(placeholderImages.length)]);
    void _showFullScreenImage(BuildContext context, int initialIndex) {
      PageController _pageController =
          PageController(initialPage: initialIndex);

      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          backgroundColor: colorBlack.withAlpha(500),
          insetPadding: EdgeInsets.all(0), // ✅ Full-screen mode
          child: SwipableImageFullscreen(
            images: _images,
            initialIndex: initialIndex,
          ),
        ),
      );
    }

    return DashboardLayout(
      title: 'Photo & Videos',
      bodyColor: bgPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            16.height,
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 0),
              physics: BouncingScrollPhysics(), // ✅ Smooth scrolling effect
              shrinkWrap: true,

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // ✅ 2 items per row (adjustable)
                crossAxisSpacing: 1, // ✅ Space between columns
                mainAxisSpacing: 1, // ✅ Space between rows
                childAspectRatio: 1.2, // ✅ Adjust item width/height ratio
              ),
              itemCount: _images.length, // ✅ Total number of photos
              itemBuilder: (context, index) {
                String imagePath = _images[index];

                return GestureDetector(
                  onTap: () => _showFullScreenImage(
                      context, index), // ✅ Open full-screen on tap
                  child: Hero(
                    tag: "image_$index", // ✅ Unique tag for smooth animation
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: AssetImage(
                  //         imagePath,
                  //       ),
                  //       fit: BoxFit
                  //           .cover, // 👈 Ensures the image covers the whole container
                  //     ),
                  //     color: Colors.grey[300],
                  //     borderRadius: BorderRadius.circular(4),
                  //   ),
                  //   alignment: Alignment.center,
                  // ),
                );
              },
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
