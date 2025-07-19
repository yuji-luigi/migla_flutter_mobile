const String notificationListQuery = r"""
query NotificationListQuery($locale: LocaleInputType!) {
  Notifications(
  locale: $locale
  where:{
    
  }){
     docs{
      id
      title
      type
      isRead
      hasAttachments
      createdAt
     
     
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
    isRead
    hasAttachments
    createdAt
     links{
      id
      link{
        type
        label
        url
        appearance 
        reference{
          value{
					... on Page { slug }
					... on Post { slug }
          }
        }
      }
    }
    attachments {
      id
      url
      filename
      mimeType
    }
  }
}
''';
