import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/screens/auth/auth_gate.dart';
import 'package:migla_flutter/src/view_models/students_view_model.dart';
import 'package:migla_flutter/src/views/dashboard_home/bottom_section/dashboard_home_bottom_section.dart';
import 'package:migla_flutter/src/views/dashboard_home/top_section/dashboard_home_top_section.dart';
import 'package:migla_flutter/src/widgets/scaffold/dashboard_home_scaffold.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen>
    with RouteAware {
  late GraphQLClient _gqlClient;

  @override
  void initState() {
    super.initState();
    _handleInitializeStudentsAndMessaging();
  }

  @override
  void didUpdateWidget(DashboardHomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleInitializeStudentsAndMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return AuthGate(
      child: DashboardHomeScaffold(
        topSection: DashboardHomeTopSection(),
        bottomSection: Column(
          children: [
            DashboardHomeBottomSection(),
          ],
        ),
      ),
    );
  }

  _handleInitializeStudentsAndMessaging() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _gqlClient = GraphQLProvider.of(context).value;
      StudentsViewModel studentsViewModel =
          $studentsViewModel(context, listen: false);
      studentsViewModel.getStudents(context);
      // int? userId = await Storage.getUserId();
      // if (userId == null) {
      //   //send back to login
      // }
      // initMessagingForUser(userId: userId!, gqlClient: _gqlClient);
    });
  }
}
