import 'package:flutter/material.dart';

class ListViewGeneral<T> extends StatelessWidget {
  final List<T> items;
  final int itemCount;
  final Function()? refetch;
  final bool shrinkWrap;
  final double bottomSpacing;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  const ListViewGeneral({
    super.key,
    required this.items,
    required this.itemCount,
    this.refetch,
    required this.itemBuilder,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.bottomSpacing = 48,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          if (refetch != null) {
            refetch!();
          }
        },
        child: separatorBuilder != null
            ? ListView.separated(
                itemCount: itemCount + 1,
                shrinkWrap: shrinkWrap,
                padding: EdgeInsets.all(0),
                separatorBuilder: separatorBuilder!,
                itemBuilder: (context, index) {
                  if (index == itemCount) {
                    return SizedBox(height: bottomSpacing);
                  }
                  return itemBuilder(context, index);
                },
              )
            : ListView.builder(
                itemCount: itemCount,
                shrinkWrap: shrinkWrap,
                padding: EdgeInsets.all(0),
                itemBuilder: itemBuilder,
              ));

    // child: Column(
    //   spacing: 8,
    //   children: [
    //     16.height,
    //     ...items.asMap().entries.map(
    //       (e) {
    //         final ReportSumModel report = e.value;
    //         if (e.key == 0) {
    //           return GestureDetector(
    //             onTap: () {
    //               TeacherReportDetailScreen(id: report.id)
    //                   .launch(context);
    //             },
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(
    //                   horizontal: paddingXDashboardMd),
    //               child: TeacherReportImageContainer(
    //                 textColor: colorWhite,
    //                 image: report.coverImage?.url,
    //                 title: report.title,
    //                 isRead: report.isRead,
    //               ),
    //             ),
    //           );
    //         }
    //         return GestureDetector(
    //           onTap: () {
    //             TeacherReportDetailScreen(id: report.id)
    //                 .launch(context);
    //           },
    //           child: TeacherReportListCard(
    //             image: report.coverImage?.url ?? '',
    //             subtitle: formatDateTime(report.createdAt),
    //             title: report.title,
    //             isRead: report.isRead,
    //           ),
    //         );
    //       },
    //     ),
    //     16.height,
    //   ],
    // ),
  }
}
