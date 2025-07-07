const String getStudentsByParentId = r'''
query StudentsByParentId($userId: JSON!){
  Students(where :{
     parents: {
     equals: $userId
     }
  }) {
    docs {
      id
      name
      surname
      classroom{
        id
        name
        teachers{
          id
          name
        }
      }
      slug
      createdAt
    }
  }
}
''';

const String getStudentByIdQuery = r'''
query GetStudentByIdQuery($studentId: Int!){
  Student(id:$studentId){
    id
    name
    surname
    classroom{
    id
      name
      teachers{
        id
        name
      }
    }
  }
}
''';
