const String fcmTokenQuery = r"""
query GetFcmTokenQuery($token: String!) {
  FcmTokens(where:{
    token: {equals: $token}
  })
{

docs {
  id
  token
}
 totalDocs
}

}
""";
const String fcmTokenQueryByUserId = r"""
query GetFcmTokenQuery($userId: JSON!) {
  FcmTokens(where:{
    user: {equals: $userId}
  })
{

docs {
  token
}
 totalDocs
}

}
""";
