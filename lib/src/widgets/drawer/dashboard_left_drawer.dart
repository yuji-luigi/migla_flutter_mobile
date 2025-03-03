import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_top.dart';
import 'package:migla_flutter/src/screens/dashboard/photo_videos_screens/photo_videos_top_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/setting_screens/settings_screen.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardLeftDrawer extends StatelessWidget {
  const DashboardLeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colorTertiary,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: paddingXDashboardMd,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: colorBlack.withAlpha(200),
                    borderRadius: BorderRadius.all(Radius.circular(900)),
                  ),
                  child: CloseButton(
                    color: colorWhite,
                  ),
                ),
              ],
            ),
            ListView.builder(
              itemCount: getDrawerItem(context).length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final item = getDrawerItem(context)[index];
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: paddingXDashboardMd,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(900),
                    ),
                    onTap: () => item.widget.launch(context),
                    leading: SvgPicture.asset(
                      item.icon,
                      width: 24,
                      height: 24,
                    ),
                    title:
                        Text(item.title, style: TextStyle(color: colorBlack)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final String icon;
  final String title;
  final Widget widget;

  DrawerItem({required this.icon, required this.title, required this.widget});
}

List<DrawerItem> getDrawerItem(BuildContext context) {
  return [
    DrawerItem(
      icon: svgGallery,
      title: context.t.navGallery,
      widget: PhotoVideosTopScreen(),
    ),
    DrawerItem(
      icon: svgMail,
      title: context.t.notificationTitle,
      widget: NotificationTopScreen(),
    ),
    DrawerItem(
      icon: svgCog,
      title: context.t.navSettings,
      widget: SettingsScreen(),
    ),
  ];
}
