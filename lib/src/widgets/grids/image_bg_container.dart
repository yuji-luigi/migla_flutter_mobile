import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/radius_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class ImageBgContainer extends StatelessWidget {
  final String image;
  final String title;
  const ImageBgContainer({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radiusMedium),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover, // 👈 Ensures the image covers the whole container
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withAlpha(0),
              colorWhite.withAlpha(200),
            ],
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Text(
          title,
          style: context.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: colorBlack,
          ),
        ),
      ),
    );
  }
}
