const String updateFcmTokenMutation = r"""
mutation UpdateUserFcm($id: Int!, $token: String!) {
  updateUser(
    id: $id
    data: { fcmToken: $token }
  ) {
    id
    fcmToken
    surname
    fullname
    createdAt
  }
}
""";
