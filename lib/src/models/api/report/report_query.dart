String Function(int) reportByStudentIdQuery = (int studentId) => """
query{
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

String Function(int) reportById = (int id) => """
query{
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
