const String reportByStudentIdQuery = r"""
query reportByStudentIdQuery($studentId: JSON!, $locale: LocaleInputType!){
  Reports(
  locale: $locale
  where:{
    students:{
      equals:$studentId
    }
    
  }
  
  ){
    docs {
      id
      title
      subtitle
      body
      createdAt
      updatedAt
      teacher{
        id
        name
      }
      attachments {
        id
        url
        mimeType
        filename
      }
      coverImage{
       id
       url
              }
    }
  }
}
""";

const String reportById = r"""
query ReportById($id: Int!, $locale: LocaleInputType!){
   Report(id:$id locale: $locale){
      id
      title
      subtitle
      body
      createdAt
      updatedAt
      teacher{
      id
        name
      }
      attachments {
        id
        url
        mimeType
        filename
      }
      coverImage{
        id
        url
      }
    
  }
}
""";
