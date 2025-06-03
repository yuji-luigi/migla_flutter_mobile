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
        name
      }
      attachments {
        id
        url
      }
      coverImage{
       id
        url
      }
    }
  }
}
""";
