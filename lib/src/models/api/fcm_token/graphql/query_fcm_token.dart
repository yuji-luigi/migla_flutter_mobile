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

const String fcmTokenQueryByUserIdAndToken = r"""
query GetFcmTokenQuery($userId: JSON!, $token: String!) {
  FcmTokens(where:{
    user: {equals: $userId}
    token: {equals: $token}
  })
{


 totalDocs
}

}
""";
