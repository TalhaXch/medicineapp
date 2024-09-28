import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineService {
  final CollectionReference medicinesCollection =
  FirebaseFirestore.instance.collection('medicines');

  Future<void> uploadJsonToFirestore() async {
    // Load the JSON file from assets
    String jsonString = await rootBundle.rootBundle.loadString('assets/data/medicines.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    WriteBatch batch = FirebaseFirestore.instance.batch();

    // Loop through the JSON data and upload it to Firestore
    jsonData['medicines'].forEach((key, value) {
      DocumentReference docRef = medicinesCollection.doc(key);
      batch.set(docRef, value);
    });

    // Commit the batch
    await batch.commit();
    print('Data successfully uploaded to Firestore');
  }
}
