import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get db =>
      FirebaseFirestore.instance.collection('usuarios').doc(uid).collection('remedios');

  Stream<QuerySnapshot> listar() => db.snapshots();

  Future<void> excluir(String id) async => db.doc(id).delete();
}
