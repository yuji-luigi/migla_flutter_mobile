String Function(int) getStudentsByParentId = ((int userId) => '''
query {
  Students(where :{
    # parent: $userId
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
      createdAt,
    }
  }

}
''');
