String meQuery = """
query{
  meUser{
    user{
      id
      name
      surname
      email
      fullname
      currentRole{
        isParent
        isTeacher
        isSuperAdmin
        isAdminLevel
      }
    }
  }
}""";
