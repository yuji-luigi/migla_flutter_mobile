import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:migla_flutter/src/models/api/media/media_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfView extends StatefulWidget {
  final MediaModel media;
  // final String name;
  // final bool hasNext;
  // final bool hasPrev;
  // final void Function() onNextFile;
  // final void Function() onPrevFile;

  const PdfView({
    Key? key,
    required this.media,
    // required this.name,
    // required this.hasNext,
    // required this.hasPrev,
    // required this.onNextFile,
    // required this.onPrevFile,
  }) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  Uint8List? pdfBytes;
  String? downloadedFilePath;
  String? error;
  bool showNextArrow = false;
  bool showPrevArrow = false;
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl();
    // if (widget.hasPrev) {
    //   showPrevArrow = true;
    // }
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (widget.hasNext && (pages != null || pages == 0)) {
    //     showNextArrow = true;
    //   }
    // });
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      var request = await HttpClient().getUrl(Uri.parse(widget.media.url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();

      print("Download files");
      print("${dir.path}/${widget.media.filename}");
      File file = File("${dir.path}/${widget.media.filename}");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      print("Download error: $e"); // 👈 Add this to see the real issue

      throw Exception('Error parsing asset file!');
    }
    File file = await completer.future;
    setState(() {
      downloadedFilePath = file.path;
    });
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (downloadedFilePath != null)
            PDFView(
              filePath: downloadedFilePath!,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
                  false, // if set to true the link is handled in flutter
              backgroundColor: Colors.black,
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                print(error.toString());
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
                pdfViewController.getPageCount().then((value) {
                  print('page count: $value');
                });
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },

              onPageChanged: (int? page, int? total) {
                print('page change: ${(page ?? 0) + 1}/${(total ?? 0)}');
                // setState(() {
                //   currentPage = page;
                //   if (page == 0) {
                //     showPrevArrow = widget.hasPrev;
                //   } else {
                //     showPrevArrow = false;
                //   }
                //   if (((page ?? 0) + 1) == pages) {
                //     showNextArrow = widget.hasNext;
                //   } else {
                //     showNextArrow = false;
                //   }
                // });
              },
            ),
          if (showPrevArrow)
            Positioned(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      // widget.onPrevFile();
                    },
                  ),
                ),
              ),
            ),
          if (showNextArrow)
            Positioned(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    onPressed: () {
                      // widget.onNextFile();
                    },
                  ),
                ),
              ),
            ),
          errorMessage.isEmpty
              ? (!isReady || downloadedFilePath == null)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}
