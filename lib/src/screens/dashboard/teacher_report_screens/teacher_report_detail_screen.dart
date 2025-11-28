import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/report/report_model.dart';
import 'package:migla_flutter/src/models/api/report/report_query.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/widgets/list/gallery_grid/tappable_image.dart';
import 'package:migla_flutter/src/widgets/media_preview/media_preview.dart';
import 'package:migla_flutter/src/widgets/media_preview/media_preview_fullscreen.dart';
import 'package:migla_flutter/src/widgets/row_avatar_with_title.dart';
import 'package:nb_utils/nb_utils.dart';

class TeacherReportDetailScreen extends StatelessWidget {
  final int id;
  const TeacherReportDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final locale = $settingsController(context).locale;

    return Query(
      options: QueryOptions(
        document: gql(reportById),
        variables: {
          'id': id,
          'locale': locale.languageCode,
        },
      ),
      builder: (
        result, {
        fetchMore,
        refetch,
      }) {
        final rawReport = result.data?['Report'];

        final report = ReportDetailModel.tryFromJson(rawReport);

        String title = result.isLoading
            ? context.t.loading
            : report?.title ?? context.t.not_found;

        return RegularLayoutScaffold(
          bgCircleBottomRightColor: colorTertiary.withAlpha(50),
          bgCircleTopLeftColor: colorTertiary.withAlpha(100),
          backgroundColor: colorPrimary,
          bodyColor: Colors.transparent,
          // bodyGradient: LinearGradient(
          //   colors: [colorPrimary, colorWhite],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          title: title,
          padding: EdgeInsets.symmetric(horizontal: 24),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: result.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: report == null
                        ? Text('Report not found')
                        : result.hasException
                            ? Text(result.exception?.graphqlErrors.toString() ??
                                'error occurred')
                            : Column(
                                spacing: 8,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 16,
                                    children: [
                                      0.height,
                                      RowAvatarWithTitle(
                                        text: report.teacher.name,
                                      ),
                                      if (report.coverImage?.url != null)
                                        TappableImage(
                                          imagePath: report.coverImage!.url,
                                          tag: "coverImage",
                                          // images: data["gallery"],
                                          height: 200,
                                        ),
                                      Text(report.title,
                                          style: textStyleTitleLg),
                                    ],
                                  ),
                                  Text(report.body, style: textStyleBodyMedium),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        formatDateTime(report.createdAt,
                                            localeCode:
                                                $settingsController(context)
                                                    .locale
                                                    .languageCode),
                                        style: textStyleHeadingMedium,
                                      ),
                                    ],
                                  ),
                                  if (report.attachments.isNotEmpty) ...[
                                    Divider(
                                      color: colorTertiary,
                                      thickness: 3,
                                    ),
                                    Text(context.t.attachments,
                                        style: textStyleHeadingMedium),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        // alignment: WrapAlignment.center,
                                        children: [
                                          ...report.attachments.map(
                                            (media) => GestureDetector(
                                              onTap: () =>
                                                  MediaPreviewFullscreen(
                                                media: media,
                                                backgroundColor:
                                                    colorPrimaryDark,
                                              ).launch(context),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                child: AbsorbPointer(
                                                  absorbing: true,
                                                  child: SizedBox(
                                                      height: 80,
                                                      width: 80,
                                                      child: MediaPreview(
                                                        media: media,
                                                        backgroundColor:
                                                            colorPrimary,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                  40.height,
                                  // GalleryGrid(
                                  //   images: report["attachments"]
                                  //       .map<String>((e) => e["url"])
                                  //       .toList(),
                                  //   columns: 3,
                                  // )
                                ],
                              ),
                  ),
          ),
        );
      },
    );
  }
}

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
