import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:migla_flutter/src/widgets/pdf_view/pdf_view.dart';
import 'package:path_provider/path_provider.dart';

class MediaPreviewFullscreen extends StatelessWidget {
  final MediaModel media;
  final Color? backgroundColor;
  const MediaPreviewFullscreen(
      {super.key, required this.media, this.backgroundColor});

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

    Future<void> handleDownload() async {
      // TODO: Implement download
      final snackBarLoading = SnackBar(
        content: Text('Downloading ${media.filename} …'),
        duration: const Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBarLoading);

      try {
        // 1) Download the file bytes
        final Uri uri = Uri.parse(media.url);
        final request = await HttpClient().getUrl(uri);
        final response = await request.close();
        if (response.statusCode != 200) {
          throw Exception('HTTP ${response.statusCode}');
        }
        final bytes = await consolidateHttpClientResponseBytes(response);

        // 2) Choose a directory to save. On iOS this is sandboxed Documents.
        //    On Android you could pick getExternalStorageDirectory() or
        //    getApplicationDocumentsDirectory(). Here we use the app's Documents folder:
        final dir = await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/${media.filename}';
        final file = File(filePath);

        // 3) Write the downloaded bytes to that file
        await file.writeAsBytes(bytes, flush: true);

        // 4) Show a SnackBar with the saved path
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saved to $filePath'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () {
                // Optionally, launch the PDF using any "open file" plugin,
                // or navigate to another screen that displays it.
                // For example, you could do:
                // OpenFile.open(filePath);
              },
            ),
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // title: Text(media.extension ?? ''),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(context.t.downloadModal_title),
                  content: Column(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(media.filename ?? ''),
                      Text(context.t.downloadModal_description),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(context.t.cancel),
                    ),
                    TextButton(
                      onPressed: handleDownload,
                      child: Text(context.t.download),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: preview,
    );
  }
}
