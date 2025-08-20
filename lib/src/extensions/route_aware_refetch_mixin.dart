import 'package:flutter/material.dart';
import 'package:migla_flutter/src/app.dart';

/// A mixin that provides RouteAware functionality with automatic refetching
/// for GraphQL queries when the screen is popped and returned to.
mixin RouteAwareRefetchMixin<T extends StatefulWidget> on State<T>
    implements RouteAware {
  Function? _refetchFunction;

  /// Store the refetch function for later use
  void setRefetchFunction(Function? refetch) {
    _refetchFunction = refetch;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to route changes
    MyApp.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // Unsubscribe from route changes
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // This is called when the screen is popped and we return to it
    // Refetch the data to get the latest data
    if (_refetchFunction != null) {
      _refetchFunction!();
    }
  }

  @override
  void didPushNext() {
    // This is called when we navigate to another screen
    // Override this method if you need custom logic when navigating away
  }

  @override
  void didPop() {
    // This is called when this screen is popped
    // Override this method if you need custom logic when this screen is popped
  }

  @override
  void didPush() {
    // This is called when this screen is pushed
    // Override this method if you need custom logic when this screen is pushed
  }
}
