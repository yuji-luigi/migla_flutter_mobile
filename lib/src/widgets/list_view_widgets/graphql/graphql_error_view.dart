import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/utils/gql_result_has_403.dart';
import 'package:nb_utils/nb_utils.dart';

class GraphqlErrorView extends StatelessWidget {
  final QueryResult result;
  final Function()? refetch;
  const GraphqlErrorView(
      {super.key, required this.result, required this.refetch});

  @override
  Widget build(BuildContext context) {
    if (gqlResultHas403(result)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // check still mounted before navigating:
        if (context.mounted) {
          LoginScreen().launch(context, isNewTask: true);
        }
      });
    }
    return RefreshIndicator(
      onRefresh: () async {
        if (refetch != null) {
          refetch!();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(result.exception?.graphqlErrors.toString() ??
                      context.t.error_somethingWentWrong),
                  IconButton(
                    iconSize: 48,
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      if (refetch != null) {
                        refetch!();
                      }
                    },
                  ),
                  Text(context.t.refreshPage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GraphQLResult {}
