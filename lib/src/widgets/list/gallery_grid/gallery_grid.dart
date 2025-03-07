import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/images/swipable_image_fullscreen.dart';

class GalleryGrid extends StatelessWidget {
  final List<String> images;
  final int columns;
  final double aspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  const GalleryGrid({
    super.key,
    required this.images,
    this.columns = 4,
    this.aspectRatio = 1.2,
    this.crossAxisSpacing = 1,
    this.mainAxisSpacing = 1,
  });

  @override
  Widget build(BuildContext context) {
    // void showFullScreenImage(BuildContext context, int initialIndex) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => Dialog(
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(0),
    //       ),
    //       backgroundColor: colorBlack.withAlpha(500),
    //       insetPadding: EdgeInsets.all(0), // ✅ Full-screen mode
    //       child: SwipableImageFullscreen(
    //         images: images,
    //         initialIndex: initialIndex,
    //       ),
    //     ),
    //   );
    // }

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      physics: BouncingScrollPhysics(), // ✅ Smooth scrolling effect
      shrinkWrap: true,

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, // ✅ 2 items per row (adjustable)
        crossAxisSpacing: crossAxisSpacing, // ✅ Space between columns
        mainAxisSpacing: mainAxisSpacing, // ✅ Space between rows
        childAspectRatio: aspectRatio, // ✅ Adjust item width/height ratio
      ),
      itemCount: images.length, // ✅ Total number of photos
      itemBuilder: (context, index) {
        String imagePath = images[index];
        return GalleryGridItem(
          imagePath: imagePath,
          index: index,
          images: images,
        );
        // return GestureDetector(
        //   onTap: () =>
        //       showFullScreenImage(context, index), // ✅ Open full-screen on tap
        //   child: Hero(
        //     tag: "image_$index", // ✅ Unique tag for smooth animation
        //     child: Container(
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage(imagePath),
        //           fit: BoxFit.cover,
        //         ),
        //         color: Colors.grey[300],
        //         borderRadius: BorderRadius.circular(4),
        //       ),
        //       alignment: Alignment.center,
        //     ),
        //   ),
        // );
      },
    );
  }
}

class GalleryGridItem extends StatelessWidget {
  final String imagePath;
  final int index;
  final double? height;
  final List<String>? images;
  final String? tag;
  const GalleryGridItem({
    super.key,
    required this.imagePath,
    this.index = 0,
    this.images,
    this.height,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    void showFullScreenImage(BuildContext context, int initialIndex) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          backgroundColor: colorBlack.withAlpha(500),
          insetPadding: EdgeInsets.all(0), // ✅ Full-screen mode
          child: SwipableImageFullscreen(
            images: images ?? [imagePath],
            initialIndex: initialIndex,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () =>
          showFullScreenImage(context, index), // ✅ Open full-screen on tap
      child: Hero(
        tag: tag ?? "image_$index", // ✅ Unique tag for smooth animation
        child: Container(
          height: height,
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
    );
  }
}
