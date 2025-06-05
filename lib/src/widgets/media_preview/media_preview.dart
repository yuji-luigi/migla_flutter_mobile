import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:migla_flutter/src/widgets/pdf_view/pdf_view.dart';

class MediaPreview extends StatelessWidget {
  final MediaModel media;
  final Color? backgroundColor;
  const MediaPreview({super.key, required this.media, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    Map<String, Widget Function(MediaModel)> mediaPreviewMap = {
      'pdf': (MediaModel media) => PdfView(
            backgroundColor: backgroundColor,
            media: media,
          ),
      // 'doc': Icon(Icons.picture_as_pdf),
      // 'docx': Icon(Icons.picture_as_pdf),
      // 'xls': Icon(Icons.picture_as_pdf),
      // 'xlsx': Icon(Icons.picture_as_pdf),
    };
    Widget preview = mediaPreviewMap[media.extension]?.call(media) ??
        Text(media.extension ?? '');

    return preview;
  }
}
