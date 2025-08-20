import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/images/swipable_image_fullscreen.dart';
import 'package:migla_flutter/src/widgets/list/gallery_grid/gallery_grid.dart';
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
    // void _showFullScreenImage(BuildContext context, int initialIndex) {
    //   PageController _pageController =
    //       PageController(initialPage: initialIndex);

    //   showDialog(
    //     context: context,
    //     builder: (context) => Dialog(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(0),
    //       ),
    //       backgroundColor: colorBlack.withAlpha(500),
    //       insetPadding: EdgeInsets.all(0), // ✅ Full-screen mode
    //       child: SwipableImageFullscreen(
    //         images: _images,
    //         initialIndex: initialIndex,
    //       ),
    //     ),
    //   );
    // }

    return RegularLayoutScaffold(
      title: 'Photo & Videos',
      bodyColor: bgPrimaryColor,
      body: SingleChildScrollView(
        child: GalleryGrid(images: _images),
      ),
    );
  }
}
