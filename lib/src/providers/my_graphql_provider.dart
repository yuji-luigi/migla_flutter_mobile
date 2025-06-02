import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:provider/provider.dart';

class MyGraphqlProvider extends StatelessWidget {
  final Widget child;
  const MyGraphqlProvider({
    super.key,
    required this.child,
  });

  Widget build(BuildContext context) {
    return Selector<AuthTokenProvider, String?>(
      selector: (_, provider) => provider.token,
      builder: (context, token, _) {
        final httpLink = HttpLink(apiGraphqlUrl);
        final authLink = AuthLink(
          getToken: () async => token == null ? null : 'Bearer $token',
        );
        final link = authLink.concat(httpLink);

        final client = ValueNotifier(
          GraphQLClient(
            link: link,
            cache: GraphQLCache(store: HiveStore()),
          ),
        );

        return GraphQLProvider(client: client, child: child);
      },
    );
  }
}
