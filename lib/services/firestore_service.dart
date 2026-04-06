import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collection = "items";

  Future<void> addItem(Item item) async => await _db.collection(collection).add(item.toMap());
  Future<void> updateItem(Item item) async => await _db.collection(collection).doc(item.id).update(item.toMap());
  Future<void> deleteItem(String id) async => await _db.collection(collection).doc(id).delete();

  Stream<List<Item>> getItems() {
    return _db.collection(collection).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Item.fromMap(doc.id, doc.data())).toList(),
        );
  }
}