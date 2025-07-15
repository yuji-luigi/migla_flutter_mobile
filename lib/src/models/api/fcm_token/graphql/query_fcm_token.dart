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
