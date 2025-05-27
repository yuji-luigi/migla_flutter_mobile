import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/students/graphql/students_query.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class DashboardHomeTopSection extends StatelessWidget {
  const DashboardHomeTopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(getStudentsByParentId(
            16)), // this is the query string you just created

        pollInterval: const Duration(seconds: 10),
      ),
      builder: (result, {fetchMore, refetch}) {
        print(result.data);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                context.t.dashboardHomeScreenHeader,
                textAlign: TextAlign.center,
                style: textStyleBodySmall,
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  maxWidth: 300,
                  maxHeight: 100,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ...List.generate(
                        3,
                        (index) => Positioned(
                              left: 30,
                              top: 0,
                              bottom: 0,
                              right: 30 * index.toDouble(),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                  avatarPlaceholder,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )).toList()
                  ],
                ),
              ),
            ),
            Text(
              context.t.dashboardHomeScreenHeader,
              textAlign: TextAlign.center,
              style: textStyleHeadingMedium.copyWith(color: textColorWhite),
            ),
          ],
        );
      },
    );
  }
}
