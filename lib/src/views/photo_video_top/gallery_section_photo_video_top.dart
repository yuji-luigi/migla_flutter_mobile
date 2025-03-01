import 'package:flutter/material.dart';
import 'package:migla_flutter/src/widgets/grids/image_bg_container.dart';
import 'package:nb_utils/nb_utils.dart';

class GallerySectionPhotoVideoTop extends StatelessWidget {
  const GallerySectionPhotoVideoTop({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> galleryList = [
      {
        "image": "assets/images/kyubi.jpeg",
        "title": "Picnic aprile 2025",
      },
      {
        "image": "assets/images/salone.jpeg",
        "title": "Salone 2025",
      },
      {
        "image": "assets/images/me_sunglasses.jpeg",
        "title": "Sunglasses aprile 2025",
      },
      {
        "image": "assets/images/kyubi.jpeg",
        "title": "Picnic aprile 2025",
      },
      {
        "image": "assets/images/salone.jpeg",
        "title": "Salone 2025",
      },
      {
        "image": "assets/images/me_sunglasses.jpeg",
        "title": "Sunglasses aprile 2025",
      },
    ];
    // return ListView.builder(
    //   itemCount: galleryList.length,
    //   // primary: false,
    //   // physics: NeverScrollableScrollPhysics(),
    //   itemBuilder: (context, index) => ImageBgContainer(
    //     image: galleryList[index]["image"],
    //     title: galleryList[index]["title"],
    //   ),
    // );
    return Column(
      spacing: 16,
      children: [
        ...galleryList.map(
          (e) => ImageBgContainer(
            image: e["image"],
            title: e["title"],
          ),
        ),
        16.height,
      ],
    );
  }
}
