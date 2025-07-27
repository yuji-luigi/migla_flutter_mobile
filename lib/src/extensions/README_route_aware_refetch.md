# RouteAwareRefetchMixin

This mixin provides automatic refetching of GraphQL queries when a screen is popped and returned to. It's useful for keeping data fresh when users navigate back to a screen.

## How it works

1. **RouteObserver Setup**: The `RouteObserver` is configured in `MyApp` to track navigation events
2. **RouteAware Implementation**: The mixin implements `RouteAware` to listen for route changes
3. **Automatic Refetch**: When `didPopNext()` is called (screen is returned to), it automatically calls the stored refetch function

## Usage

### 1. Add the mixin to your StatefulWidget

```dart
class _MyScreenState extends State<MyScreen> with RouteAwareRefetchMixin {
  @override
  Widget build(BuildContext context) {
    return Query(
      // ... your query options
      builder: (result, {fetchMore, refetch}) {
        // Store the refetch function
        setRefetchFunction(refetch);
        
        // ... rest of your builder logic
      },
    );
  }
}
```

### 2. That's it!

The mixin will automatically:
- Subscribe to route changes when the screen is built
- Unsubscribe when the screen is disposed
- Refetch the query when you return to the screen

## Available Methods

You can override these methods for custom behavior:

- `didPopNext()`: Called when returning to this screen (default: refetches data)
- `didPushNext()`: Called when navigating away from this screen
- `didPop()`: Called when this screen is popped
- `didPush()`: Called when this screen is pushed

## Example

```dart
class _NotificationListScreenState extends State<NotificationListScreen> 
    with RouteAwareRefetchMixin {
  
  @override
  void didPopNext() {
    super.didPopNext(); // This will refetch automatically
    // Add any additional logic here
  }
  
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(myQuery),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
      ),
      builder: (result, {fetchMore, refetch}) {
        setRefetchFunction(refetch); // Store for automatic refetching
        
        // Your existing builder logic...
        return YourWidget();
      },
    );
  }
}
```

## Requirements

- Your app must have a `RouteObserver` configured in `MaterialApp.navigatorObservers`
- The screen must use a `Query` widget from `graphql_flutter`
- The screen must be a `StatefulWidget` 