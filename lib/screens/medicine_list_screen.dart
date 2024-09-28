import 'package:flutter/material.dart';
import 'package:medicineapi/services/medicine_service.dart';

class MedicineListScreen extends StatefulWidget {
  @override
  _MedicineListScreenState createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  final MedicineService _medicineService = MedicineService();
  List<String> _medicines = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchMedicines();
  }

  _fetchMedicines() async {
    try {
      final medicines = await _medicineService.getMedicines();
      setState(() {
        _medicines = medicines;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print('Failed to load medicines: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medicine List'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _medicines.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_medicines[index]),
          );
        },
      ),
    );
  }
}
