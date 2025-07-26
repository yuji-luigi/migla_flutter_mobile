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
      readRecords{
        docs{
          id
        }
      }
      hasAttachments
      createdAt
     
     
    }
    
  }
}
""";
const String notificationDetailQuery = r'''
query NotificationDetail($id: Int! $locale: LocaleInputType!) {
  Notification(id: $id, locale: $locale) {
    id
    title
    body
    type
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
