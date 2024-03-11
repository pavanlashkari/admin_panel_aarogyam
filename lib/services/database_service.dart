import 'package:admin_panel_aarogyam/data%20model/AddMedicineModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

 Future<String> addMedicine(AddMedicineModel addMedicineModel) async {
    try{
      String documentId = FirebaseFirestore.instance.collection("medicineDetails").doc().id;
      await _db
          .collection("medicineDetails")
          .doc(documentId)
          .set(addMedicineModel.toMap());
      await _db.collection("medicineDetails").doc(documentId).update({
        'documentId': documentId,
      });
      return documentId;
    }catch(e){
      print(e.toString());
      throw e;
    }
  }
  Future<void> deleteMedRecord(AddMedicineModel addMedicineModel,docId)async{
   await _db.collection("medicineDetails").doc(docId).delete();
  }

  updateMedicine(AddMedicineModel addMedicineModel,docId) async {
    await _db.collection("medicineDetails").doc(docId).update(addMedicineModel.toMap());
  }

  Future<AddMedicineModel> retrieveMedicine(
      AddMedicineModel addMedicineModel) async {
    final snapshot = await _db.collection("medicineDetails").doc().get();
    return AddMedicineModel.fromDocumentSnapshot(snapshot);
  }

  Future<List<AddMedicineModel>> retrieveAllMedicine() async {
    final snapshot = await _db.collection("medicineDetails").get();
    return snapshot.docs
        .map((element) => AddMedicineModel.fromDocumentSnapshot(element))
        .toList();
  }
}
