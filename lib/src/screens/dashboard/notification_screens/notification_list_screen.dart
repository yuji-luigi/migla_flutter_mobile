import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/notification/notification_detail_model.dart';
import 'package:migla_flutter/src/models/api/notification/notification_model.dart';
import 'package:migla_flutter/src/models/api/notification/notifiction_query.dart';
import 'package:migla_flutter/src/models/api/notification/util/build_list_by_month.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_detail_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/widgets/list/date_mark_as_read_tile.dart';
import 'package:migla_flutter/src/widgets/list_tile/notification_list_tile.dart';
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
          // DateMarkAsReadTile(),
          // 2.height,
          Expanded(
            child: Query(
              options: QueryOptions(
                document: gql(notificationListQuery),
                fetchPolicy: FetchPolicy.cacheAndNetwork,
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
                final display = buildDisplayList(notifications);

                return ListView.builder(
                  itemCount: display.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    if (display[index] is String) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          display[index] as String,
                          style: textStyleHeadingMedium,
                        ),
                      );
                    }
                    return NotificationListTile(
                        notification: display[index] as NotificationModel);
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
