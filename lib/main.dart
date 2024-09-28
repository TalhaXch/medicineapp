import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/medicine_list_screen.dart';
import 'services/upload.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MedicineService medicineService = MedicineService();
  await medicineService.uploadJsonToFirestore();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MedicineListScreen(),


    );
  }
}
