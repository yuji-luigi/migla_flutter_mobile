// String Function(int) getStudentsByParentId = ((int userId) => '''
// query {
//   Students(where :{
//     # parent: $userId
//   }) {
//     docs {
//       id
//       name
//       surname
//       parent{
//         name
//         surname
//       }
//       createdAt,

//     }
//   }
// }
// ''');
