import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthScaffold extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  const AuthScaffold({super.key, required this.children, this.spacing = 0});

  @override
  Widget build(BuildContext context) {
    // Future<Uint8List> svgToPng(String svgPath, BuildContext context) async {
    //   try {
    //     String svgString = await rootBundle.loadString(svgPath);

    //     final pictureInfo =
    //         await vg.loadPicture(SvgStringLoader(svgString), context);

    //     double screenHeight = context.height();
    //     double screenWidth = context.width();
    //     final image = await pictureInfo.picture.toImage(
    //       screenWidth.toInt(),
    //       screenHeight.toInt(),
    //     );
    //     final byteData = await image.toByteData(format: ImageByteFormat.png);

    //     if (byteData == null) {
    //       throw Exception('Unable to convert SVG to PNG');
    //     }

    //     final pngBytes = byteData.buffer.asUint8List();
    //     return pngBytes;
    //   } catch (e) {
    //     print(e);
    //     rethrow;
    //   }
    // }

    return Scaffold(
      backgroundColor: bgPrimaryColor,

      // body: FutureBuilder(
      //   future: svgToPng(bgAuthX, context),
      //   builder: (context, snapshot) {
      //     return Container(
      //       decoration: BoxDecoration(
      //         image: snapshot.data != null
      //             ? DecorationImage(
      //                 fit: BoxFit.contain,
      //                 image: MemoryImage(snapshot.data!),
      //               )
      //             : null,
      //       ),
      //       child: SingleChildScrollView(
      //         child: IntrinsicHeight(
      //           child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: children,
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(bgCircleTopLeft),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(bgCircleBottomRight),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Column(
                    spacing: spacing,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
