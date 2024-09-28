import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineService {
  final CollectionReference medicinesCollection =
  FirebaseFirestore.instance.collection('medicines');

  Future<List<String>> getMedicines() async {
    try {
      QuerySnapshot snapshot = await medicinesCollection.get();

      List<String> medicines = snapshot.docs.map((doc) {
        // Check if the document exists and contains the 'name' field
        if (doc.exists && doc.data() != null) {
          var data = doc.data() as Map<String, dynamic>;
          // Ensure the 'name' field exists before accessing it
          if (data.containsKey('name')) {
            return data['name'] as String; // Return the name if it exists
          } else {
            print('Field "name" does not exist in document ${doc.id}');
            return null; // Return null if the field does not exist
          }
        } else {
          print('Document does not exist: ${doc.id}');
          return null; // Return null if the document does not exist
        }
      }).where((name) => name != null).cast<String>().toList(); // Filter out null values

      medicines.sort(); // Sort alphabetically
      return medicines;
    } catch (e) {
      print('Failed to load medicines: $e');
      return []; // Return an empty list on error
    }
  }
}
