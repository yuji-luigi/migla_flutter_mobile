import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/dashboard_layout.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_detail_screen.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/list/date_mark_as_read_tile.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationTopScreen extends StatelessWidget {
  const NotificationTopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
      padding: EdgeInsets.zero,
      bodyColor: colorTertiary,
      title: context.t.notificationTitle,
      body: Column(
        children: [
          DateMarkAsReadTile(),
          2.height,
          Flexible(
            child: ListView.builder(
              itemCount: mockNotificationList.length,
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: colorTextDisabled,
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorWhite,
                      border: Border(
                        bottom: BorderSide(
                          color: colorTextDisabled,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: IntrinsicWidth(
                        child: Row(
                          spacing: 16,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: errorColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SvgPicture.asset(
                              svgIconMap[mockNotificationList[index]['type']]!,
                            ),
                          ],
                        ),
                      ),
                      title: Text(mockNotificationList[index]['title'],
                          style: textStyleBodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(
                        mockNotificationList[index]['date'],
                        style: textStyleCaptionMd.copyWith(
                          color: colorTextDisabled,
                        ),
                      ),
                      onTap: () {
                        NotificationDetailScreen(id: index).launch(context);
                      },
                      // trailing: Text(mockNotificationList[index]['trailing']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
