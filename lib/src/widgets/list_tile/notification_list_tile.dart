import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/models/api/notification/notification_model.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_detail_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
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
                ),
              ],
            ),
          ),
          title: Text(notification.title,
              style: textStyleBodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              )),
          subtitle: Text(
            formatDateTime(DateTime.parse(notification.createdAt)),
            style: textStyleCaptionMd.copyWith(
              color: colorTextDisabled,
            ),
          ),
          onTap: () {
            NotificationDetailScreen(id: notification.id).launch(context);
          },
          // trailing: Text(mockNotificationList[index]['trailing']),
        ),
      ),
    );
  }
}
