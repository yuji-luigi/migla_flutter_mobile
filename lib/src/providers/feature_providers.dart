import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:provider/provider.dart';

class FeatureProviders extends StatelessWidget {
  const FeatureProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final client = GraphQLProvider.of(context).value;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MeViewModel(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (ctx) => StudentsViewModel(
            client,
          ),
        ),
      ],
      child: child,
    );
  }
}
