import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/notification/notification_model.dart';
import 'package:migla_flutter/src/models/api/notification/notifiction_query.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_detail_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/widgets/list/date_mark_as_read_tile.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RegularLayoutScaffold(
      padding: EdgeInsets.zero,
      bodyColor: colorTertiary,
      title: context.t.notificationTitle,
      body: Column(
        children: [
          DateMarkAsReadTile(),
          2.height,
          Expanded(
            child: Query(
              options: QueryOptions(
                document: gql(notificationListQuery),
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Text(result.exception?.graphqlErrors.toString() ??
                      'error occurred');
                }
                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final List<NotificationModel> notifications = result
                        .data?['Notifications']['docs']
                        .map<NotificationModel>((notification) =>
                            NotificationModel.fromJson(notification))
                        .toList() ??
                    [];
                return ListView.builder(
                  itemCount: notifications.length,
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
                                  svgIconMap[notifications[index].type]!,
                                ),
                              ],
                            ),
                          ),
                          title: Text(notifications[index].title,
                              style: textStyleBodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              )),
                          subtitle: Text(
                            formatDateTime(
                                DateTime.parse(notifications[index].createdAt)),
                            style: textStyleCaptionMd.copyWith(
                              color: colorTextDisabled,
                            ),
                          ),
                          onTap: () {
                            NotificationDetailScreen(
                                    id: notifications[index].id)
                                .launch(context);
                          },
                          // trailing: Text(mockNotificationList[index]['trailing']),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
