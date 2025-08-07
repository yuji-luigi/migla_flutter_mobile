import 'package:graphql_flutter/graphql_flutter.dart';

bool gqlResultHas403(QueryResult result) {
  bool? is403 = result.exception?.graphqlErrors
      .any((error) => error.extensions?['statusCode'] == 403);

  return is403 ?? false;
}
