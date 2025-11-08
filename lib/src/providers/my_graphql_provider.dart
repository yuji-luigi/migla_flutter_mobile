import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/providers/auth_token_provider.dart';
import 'package:provider/provider.dart';

/// Make the cache store a singleton so it isn't recreated on rebuilds.
final HiveStore _hiveStore = HiveStore();

class MyGraphqlProvider extends StatefulWidget {
  final Widget child;
  const MyGraphqlProvider({super.key, required this.child});

  @override
  State<MyGraphqlProvider> createState() => _MyGraphqlProviderState();
}

class _MyGraphqlProviderState extends State<MyGraphqlProvider> {
  late final ValueNotifier<GraphQLClient> _client;

  @override
  void initState() {
    super.initState();
    _hiveStore.reset();
    final httpLink = HttpLink(
      apiGraphqlUrl,
    );

    // Capture the provider INSTANCE, not the token value.
    final auth = context.read<AuthTokenProvider>();

    final authLink = AuthLink(
      getToken: () async {
        final t = auth.token; // always current
        return t == null ? null : 'Bearer $t';
      },
    );

    final link = authLink.concat(httpLink);

    _client = ValueNotifier(
      GraphQLClient(
        // cache: GraphQLCache(store: InMemoryStore()), // <-- bypass Hive
        link: link,
        cache: GraphQLCache(store: _hiveStore),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // No rebuild needed on token changes; getToken reads latest at request time.
    return GraphQLProvider(
      client: _client,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _client.dispose();
    super.dispose();
  }
}

GraphQLClient getGqlClient(BuildContext context) =>
    GraphQLProvider.of(context).value;
