const String reportByStudentIdQuery = r"""
query reportByStudentIdQuery($studentId: JSON!){
  Reports(where:{
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
query ReportById($id: Int!){
  Report(id:$id){
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
