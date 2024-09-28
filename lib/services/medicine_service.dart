import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineService {
  final CollectionReference medicinesCollection =
  FirebaseFirestore.instance.collection('medicines');

  Future<List<String>> getMedicines() async {
    QuerySnapshot snapshot = await medicinesCollection.get();

    List<String> medicines = snapshot.docs.map((doc) {
      return doc['name'] as String;
    }).toList();

    medicines.sort(); // Sort alphabetically
    return medicines;
  }
}
