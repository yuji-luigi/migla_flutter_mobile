import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/objects/nav_item.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_list_screen.dart';
import 'package:migla_flutter/src/screens/dashboard/setting_screens/settings_screen.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/drawer/tiles/drawer_list_tile.dart';
import 'package:migla_flutter/src/widgets/drawer/tiles/student_switch_tile.dart';
import 'package:migla_flutter/src/widgets/popovers/account_popover.dart';

class DashboardLeftDrawer extends StatelessWidget {
  const DashboardLeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top;
    return Drawer(
      backgroundColor: colorTertiary,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: paddingTop),
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
              top: 20,
              bottom: 12,
            ),
            child: Divider(
              color: colorTextDisabled,
              height: 1,
            ),
          ),
          Expanded(
            child: Column(
              spacing: 12,
              children: [
                ...getDrawerTiles(context),
              ],
            ),
            // child: ListView.builder(
            //   itemCount: getDrawerTiles(context).length,
            //   shrinkWrap: true,
            //   padding: EdgeInsets.zero,
            //   itemBuilder: (context, index) {
            //     final item = getDrawerTiles(context)[index];
            //     return item;
            //   },
            // ),
          )
        ],
      ),
    );
  }
}

List<Widget> getDrawerTiles(BuildContext context) {
  return [
    // DrawerListTile(
    //     item: NavItem(
    //   icon: svgGallery,
    //   title: context.t.navGallery,
    //   widget: PhotoVideosTopScreen(),
    // )),
    DrawerListTile(
        item: NavItem(
      icon: svgMail,
      title: context.t.notificationTitle,
      widget: NotificationListScreen(),
    )),
    StudentSwitchTile(),
    DrawerListTile(
        item: NavItem(
      icon: svgCog,
      title: context.t.navSettings,
      widget: SettingsScreen(),
    )),
  ];
}
