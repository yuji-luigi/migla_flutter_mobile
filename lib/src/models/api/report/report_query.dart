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
      teacher{
        name
      }
      attachments {
        url
      }
    }
  }
}
""";
