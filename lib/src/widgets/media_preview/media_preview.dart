import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:migla_flutter/src/widgets/pdf_view/pdf_view.dart';

class MediaPreview extends StatelessWidget {
  final MediaModel media;
  const MediaPreview({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    Widget preview = mediaPreviewMap[media.extension]?.call(media) ??
        Text(media.extension ?? '');

    return preview;
  }
}

Map<String, Widget Function(MediaModel)> mediaPreviewMap = {
  'pdf': (MediaModel media) => PdfView(media: media),
  // 'doc': Icon(Icons.picture_as_pdf),
  // 'docx': Icon(Icons.picture_as_pdf),
  // 'xls': Icon(Icons.picture_as_pdf),
  // 'xlsx': Icon(Icons.picture_as_pdf),
};
