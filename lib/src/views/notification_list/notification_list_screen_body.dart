import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/extensions/route_aware_refetch_mixin.dart';
import 'package:migla_flutter/src/models/api/notification/notification_model.dart';
import 'package:migla_flutter/src/models/api/notification/notification_query.dart';
import 'package:migla_flutter/src/models/api/notification/util/build_list_by_month.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/gql_result_has_403.dart';
import 'package:migla_flutter/src/widgets/list/info_empty_list.dart';
import 'package:migla_flutter/src/widgets/list_tile/notification_list_tile/notification_list_tile.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationListScreenBody extends StatefulWidget {
  const NotificationListScreenBody({super.key});

  @override
  State<NotificationListScreenBody> createState() =>
      _NotificationListScreenBodyState();
}

class _NotificationListScreenBodyState extends State<NotificationListScreenBody>
    with RouteAwareRefetchMixin {
  @override
  Widget build(BuildContext context) {
    final locale = $settingsController(context).locale;

    return Column(
      children: [
        Expanded(
          child: Query(
            options: QueryOptions(
              document: gql(notificationListQuery),
              fetchPolicy: FetchPolicy.cacheAndNetwork,
              variables: {
                'locale': locale.languageCode,
              },
            ),
            builder: (result, {fetchMore, refetch}) {
              // Store the refetch function for later use
              setRefetchFunction(refetch);

              if (result.hasException) {
                if (gqlResultHas403(result)) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // check still mounted before navigating:
                    if (context.mounted) {
                      LoginScreen().launch(context, isNewTask: true);
                    }
                  });
                }
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

              if (notifications.isEmpty) {
                return InfoEmptyList(
                    title: context.t.noNotificationsFound, onRefresh: refetch);
              }

              final display = buildDisplayList(notifications);

              return ListView.builder(
                itemCount: display.length + 1,
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  if (index == display.length) {
                    return 100.height;
                  }
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
                    notification: display[index] as NotificationModel,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
