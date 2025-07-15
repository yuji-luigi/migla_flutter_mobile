const String createFcmTokenMutation = r"""
mutation CreateFcmToken(
  $userId: Int!
  $token: String!
  $osName: String!
  $osVersion: String!
) {
  createFcmToken(
    data: {
      user: $userId
      token: $token
      osName: $osName
      osVersion: $osVersion
    }
  ) {
    id
  }
}
""";
