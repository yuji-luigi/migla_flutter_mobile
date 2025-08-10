const String createReadNotificationQuery = r"""
mutation CreateReadNotification(
  $userId: Int!
  $notificationId: Int!  
) {
  createReadNotification(
    data: {
      user: $userId
      notification:
    }
  ) {
    id
  }
}

""";
