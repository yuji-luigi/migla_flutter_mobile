import 'dart:io';

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/images/swipable_image_fullscreen.dart';
import 'package:nb_utils/nb_utils.dart';

class TappableImage extends StatefulWidget {
  final String imagePath;
  // final Widget imageContainer;
  final int index;
  final double? height;
  final List<String>? images;
  final String? tag;
  final bool useBGImage;
  const TappableImage({
    super.key,
    required this.imagePath,
    // required this.imageContainer,
    this.index = 0,
    this.images,
    this.height,
    this.tag,
    this.useBGImage = true,
  });

  @override
  State<TappableImage> createState() => _TappableImageState();
}

class _TappableImageState extends State<TappableImage> {
  bool _loaded = false;
  bool _imageExists = false;

  late final ImageProvider _provider;
  late final ImageStream _stream;
  late final ImageStreamListener _listener;

  @override
  void initState() {
    super.initState();

    // 1️⃣ Choose the provider
    _provider = widget.imagePath.contains('http')
        ? NetworkImage(widget.imagePath)
        : AssetImage(widget.imagePath);

    // 2️⃣ Listen for its load / error events
    _stream = _provider.resolve(const ImageConfiguration());
    _listener = ImageStreamListener(
      (ImageInfo info, bool sync) {
        // success
        if (!mounted) return;
        setState(() {
          _loaded = true;
          _imageExists = true;
        });
        _stream.removeListener(_listener);
      },
      onError: (dynamic error, StackTrace? stack) {
        // failure
        if (!mounted) return;
        setState(() {
          _loaded = true;
          _imageExists = false;
        });
        _stream.removeListener(_listener);
      },
    );
    _stream.addListener(_listener);
  }

  @override
  void dispose() {
    _stream.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.imagePath);
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
            images: widget.images ?? [widget.imagePath],
            initialIndex: initialIndex,
          ),
        ),
      );
    }

    if (!_loaded) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: () => showFullScreenImage(
          context, widget.index), // ✅ Open full-screen on tap
      child: Hero(
        tag: widget.tag ??
            "image_${widget.index}", // ✅ Unique tag for smooth animation
        // child: imageContainer,

        child: Container(
          height: widget.height,
          alignment: Alignment.center,
          decoration: (_imageExists && widget.useBGImage)
              ? BoxDecoration(
                  image: DecorationImage(
                    image: _provider,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey[200],
                )
              : null,
          child: (!_imageExists && widget.imagePath.contains('http'))
              // show broken‐image icon on failure
              ? const Icon(Icons.broken_image, size: 48, color: Colors.red)
              // or asset / network normally
              : !widget.useBGImage
                  ? Image(
                      image: _provider,
                      fit: BoxFit.cover,
                    )
                  : null,
        ),
      ),
    );
  }
}
