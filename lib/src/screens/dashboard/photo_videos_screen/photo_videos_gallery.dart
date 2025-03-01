import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/dashboard_layout.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/views/photo_video_top/gallery_section_photo_video_top.dart';
import 'package:migla_flutter/src/widgets/buttons/chip_button.dart';
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
                crossAxisSpacing: 4, // ✅ Space between columns
                mainAxisSpacing: 4, // ✅ Space between rows
                childAspectRatio: 1.2, // ✅ Adjust item width/height ratio
              ),
              itemCount: 50, // ✅ Total number of photos
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        placeholderImages[
                            Random().nextInt(placeholderImages.length)],
                      ),
                      fit: BoxFit
                          .cover, // 👈 Ensures the image covers the whole container
                    ),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
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
