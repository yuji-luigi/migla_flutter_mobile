import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> addReport(String reportId, Map<String, dynamic> reportData) async {
  await db.collection('reports').doc(reportId).set(reportData);
}
