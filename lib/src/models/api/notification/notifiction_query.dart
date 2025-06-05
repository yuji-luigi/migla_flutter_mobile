const String notificationListQuery = r"""
query{
  Notifications(where:{
    
  }){
     docs{
      id
      title
      body
      type
      createdAt
      attachments {
        id
        url
        filename
        mimeType
      }
     
    }
    
  }
}
""";
const String notificationDetailQuery = r'''
query NotificationDetail($id: Int!) {
  Notification(id: $id) {
    id
    title
    body
    type
    createdAt
    attachments {
      id
      url
      filename
      mimeType
    }
  }
}
''';
