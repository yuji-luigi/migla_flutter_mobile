const String getStudentsByParentId = r'''
query StudentsByParentId($userId: JSON!, $locale: LocaleInputType!){
  Students(
  locale: $locale
  where :{
     parent: {
     equals: $userId
     }
  }) {
    docs {
      id
      name
      surname
      fullname
      classroom{
        id
        name
        teachers{
        docs{  
          id
          name
          }
        }
      }
      slug
      createdAt
    }
  }
}
''';

const String getStudentByIdQuery = r'''
query GetStudentByIdQuery($studentId: Int!, $locale: LocaleInputType!){
  Student(id:$studentId locale: $locale){
    id
    name
    surname
    fullname
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
