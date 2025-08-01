import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/models/api/notification/notification_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/widgets/list_tile/notification_list_tile/notification_list_tile_on_tap_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationListTile extends StatelessWidget {
  final NotificationModel notification;
  const NotificationListTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
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
                    color:
                        notification.isRead ? Colors.transparent : errorColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SvgPicture.asset(
                  svgIconMap[notification.type] ?? '',
                  height: 32,
                  width: 32,
                ),
              ],
            ),
          ),
          title: Text(notification.title,
              style: textStyleBodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification.body,
                  style: textStyleBodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                children: [
                  Spacer(),
                  Text(
                    formatDateTime(DateTime.parse(notification.createdAt)),
                    style: textStyleCaptionMd.copyWith(
                      color: colorTextDisabled,
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            final controller =
                NotificationListTileOnTapController(notification: notification);
            controller.handleOnTap(context);
          },
          // trailing: Text(mockNotificationList[index]['trailing']),
        ),
      ),
    );
  }
}
