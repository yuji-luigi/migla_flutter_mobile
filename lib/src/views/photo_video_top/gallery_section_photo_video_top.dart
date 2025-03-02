import 'package:flutter/material.dart';
import 'package:migla_flutter/src/screens/dashboard/photo_videos_screens/photo_videos_gallery.dart';
import 'package:migla_flutter/src/widgets/containers/image_bg_container.dart';
import 'package:nb_utils/nb_utils.dart';

class GallerySectionPhotoVideoTop extends StatelessWidget {
  const GallerySectionPhotoVideoTop({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> galleryList = [
      {
        "image": "assets/images/mock_images/kyubi.jpeg",
        "title": "Picnic aprile 2025",
        "date": "2025-04-01",
        "category": "week",
      },
      {
        "image": "assets/images/mock_images/salone.jpeg",
        "title": "Salone 2025",
        "date": "2025-04-18",
        "category": "category",
      },
      {
        "image": "assets/images/mock_images/me_sunglasses.jpeg",
        "title": "Sunglasses aprile 2025",
        "date": "2025-04-01",
        "category": "other",
      },
      {
        "image": "assets/images/mock_images/kyubi.jpeg",
        "title": "Picnic aprile 2025",
        "date": "2025-04-21",
        "category": "week",
      },
      {
        "image": "assets/images/mock_images/salone.jpeg",
        "title": "Salone 2025",
        "date": "2025-04-28",
        "category": "category",
      },
      {
        "image": "assets/images/mock_images/me_sunglasses.jpeg",
        "title": "Sunglasses aprile 2025",
        "date": "2025-04-28",
        "category": "other",
      },
    ];

    return Column(
      spacing: 16,
      children: [
        ...galleryList.map(
          (e) => GestureDetector(
            onTap: () => PhotoVideosGallery().launch(context),
            child: ImageBgContainer(
              image: e["image"],
              title: e["title"],
            ),
          ),
        ),
        16.height,
      ],
    );
  }
}
