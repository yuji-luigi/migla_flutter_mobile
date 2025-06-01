String meQuery = """
query{
  meUser{
    user{
      id
      name
      surname
      email
      currentRole{
        isParent
        isTeacher
        isSuperAdmin
        isAdminLevel
      }
    }
  }
}""";
