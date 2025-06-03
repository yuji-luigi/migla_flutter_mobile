import 'package:flutter/material.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class SwipableImageFullscreen extends StatelessWidget {
  final List<String> images;
  final int initialIndex;
  const SwipableImageFullscreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(initialPage: initialIndex);
    return Stack(
      children: [
        Positioned.fill(
          child: PageView.builder(
            controller: _pageController, // ✅ Enable swiping
            itemCount: images.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                panEnabled: true,
                minScale: 1.0,
                maxScale: 5.0,
                child: Hero(
                  tag: "image_$index",
                  child: Image.network(
                    host + images[index],
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 40,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: colorBlack.withAlpha(100),
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              icon: Icon(Icons.close, color: colorWhite, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }
}
