import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/notification/notification_detail_model.dart';
import 'package:migla_flutter/src/models/api/notification/notification_query.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:url_launcher/link.dart' as url_launcher;

// NOTE: this is not used anymore. but can be used => show the collection detail screen as child with some flags (no notification button...etc)
class NotificationDetailScreen extends StatelessWidget {
  final int id;
  const NotificationDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Locale locale = $settingsController(context).locale;
    return Query(
      options: QueryOptions(
        document: gql(notificationDetailQuery),
        variables: {'id': id, 'locale': locale.languageCode},
      ),
      builder: (result, {fetchMore, refetch}) {
        Widget placeholder = const Center(child: CircularProgressIndicator());
        if (result.hasException) {
          placeholder = Text(
              result.exception?.graphqlErrors.toString() ?? 'error occurred');
        }
        if (result.isLoading) {
          placeholder = const Center(child: CircularProgressIndicator());
        }
        final NotificationDetailModel? notification =
            NotificationDetailModel.tryFromJson(result.data?['Notification']);
        return RegularLayoutScaffold(
          appBarActions: [],
          title: notification?.title ?? '',
          // bodyColor: colorTertiary,
          // bodyColor: colorWhite,
          padding: EdgeInsets.all(0),
          body: notification == null
              ? placeholder
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: colorWhite,
                        padding: EdgeInsets.symmetric(
                          horizontal: paddingXDashboardLg,
                          vertical: paddingXDashboardLg,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notification.title,
                                style: textStyleBodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                            Text(notification.body,
                                style: textStyleBodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                            Wrap(
                              spacing: 8,
                              children:
                                  notification.links.map<Widget>((linkEntry) {
                                final url = linkEntry.url;
                                return url == null
                                    ? const SizedBox.shrink()
                                    : url_launcher.Link(
                                        uri: Uri.parse(url),
                                        target: url_launcher.LinkTarget.blank,
                                        builder: (context, followLink) {
                                          return TextButton(
                                            onPressed: followLink,
                                            child: Text(linkEntry.label),
                                          );
                                        },
                                      );
                              }).toList(),
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Text(
                                    formatDateTime(
                                        DateTime.parse(notification.createdAt)),
                                    textAlign: TextAlign.end,
                                    style: textStyleCaptionMd.copyWith(
                                      color: colorTextDisabled,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

List<Map<String, dynamic>> mockNotificationList = [
  {
    'title': '授業料の支払い期限が近づいています',
    'subtitle': '2025年4月分の授業料をご確認ください',
    'date': '2025/03/25',
    'type': 'payment',
  },
  {
    'title': '春休みイベントのお知らせ',
    'subtitle': '4月1日から5日まで特別イベントを開催します',
    'date': '2025/03/20',
    'type': 'event',
  },
  {
    'title': '緊急連絡：明日は臨時休校です',
    'subtitle': '悪天候のため、明日の授業は中止となります',
    'date': '2025/03/18',
    'type': 'notification',
  },
  {
    'title': '教材費の支払い確認完了',
    'subtitle': '3月分の教材費の入金を確認いたしました',
    'date': '2025/03/15',
    'type': 'payment',
  },
  {
    'title': '保護者会開催のお知らせ',
    'subtitle': '来月の保護者会の日程が決定しました',
    'date': '2025/03/10',
    'type': 'event',
  },
  {
    'title': '新型コロナ対策について',
    'subtitle': '最新の感染予防対策をご確認ください',
    'date': '2025/03/05',
    'type': 'notification',
  },
];
