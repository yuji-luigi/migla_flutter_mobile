import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/objects/nav_item.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_top.dart';
import 'package:migla_flutter/src/screens/dashboard/photo_videos_screens/photo_videos_top_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/setting_screens/settings_screen.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/popovers/account_popover.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardLeftDrawer extends StatelessWidget {
  const DashboardLeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colorTertiary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CloseButton(
                color: colorBlack,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: paddingXDashboardMd,
            ),
            child: AccountPopover(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: paddingXDashboardMd + 12,
              right: paddingXDashboardMd + 12,
              top: 12,
              bottom: 3,
            ),
            child: Divider(
              color: colorTextDisabled,
              height: 1,
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                      colorFilter: ColorFilter.mode(
                        colorBlack,
                        BlendMode.srcIn,
                      ),
                    ),
                    title:
                        Text(item.title, style: TextStyle(color: colorBlack)),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

List<NavItem> getDrawerItem(BuildContext context) {
  return [
    NavItem(
      icon: svgGallery,
      title: context.t.navGallery,
      widget: PhotoVideosTopScreen(),
    ),
    NavItem(
      icon: svgMail,
      title: context.t.notificationTitle,
      widget: NotificationTopScreen(),
    ),
    NavItem(
      icon: svgCog,
      title: context.t.navSettings,
      widget: SettingsScreen(),
    ),
  ];
}
