import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/views/photo_video_top/gallery_section_photo_video_top.dart';
import 'package:migla_flutter/src/widgets/buttons/chip_button.dart';
import 'package:migla_flutter/src/widgets/buttons/notification_appbar_action_button.dart';
import 'package:migla_flutter/src/widgets/buttons/student_switch_appbar_action_button.dart';
import 'package:nb_utils/nb_utils.dart';

String _week = 'week';
String _category = 'category';
String _other = 'other';

class PhotoVideosTopScreen extends StatefulWidget {
  const PhotoVideosTopScreen({super.key});

  @override
  State<PhotoVideosTopScreen> createState() => _PhotoVideosTopScreenState();
}

class _PhotoVideosTopScreenState extends State<PhotoVideosTopScreen> {
  String currentCategory = _category;
  void setCurrentCategory(String category) {
    setState(() {
      currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RegularLayoutScaffold(
      isUnderDevelopment: true,
      title: 'Photo & Videos',
      backgroundColor: bgPrimaryColor,
      bodyColor: Colors.transparent,
      appBarActions: [
        const StudentSwitchAppbarActionButton(),
        const NotificationAppbarActionButton()
      ],
      body: SingleChildScrollView(
        child: Column(
          children: [
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                ChipButton(
                    withShadow: true,
                    text: context.t.weekButtonText,
                    withOpacity: currentCategory == _week,
                    onTap: () => setCurrentCategory(_week),
                    backgroundColor: colorTertiary),
                ChipButton(
                    withShadow: true,
                    text: context.t.categoryButtonText,
                    withOpacity: currentCategory == _category,
                    onTap: () => setCurrentCategory(_category),
                    backgroundColor: colorPrimary),
                ChipButton(
                    withShadow: true,
                    text: context.t.otherButtonText,
                    withOpacity: currentCategory == _other,
                    onTap: () => setCurrentCategory(_other),
                    backgroundColor: colorSecondary),
              ],
            ),
            24.height,
            GallerySectionPhotoVideoTop(),
            16.height,
          ],
        ),
      ),
    );
  }
}
