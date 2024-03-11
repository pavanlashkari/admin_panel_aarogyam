import 'package:admin_panel_aarogyam/data%20model/AddMedicineModel.dart';
import 'package:admin_panel_aarogyam/services/database_service.dart';

class DatabaseRepositoryImplement extends DatabaseRepository{

  final service = DatabaseService();
  @override
  Future<void> addMedicine(AddMedicineModel addMedicineModel) {
    return service.addMedicine(addMedicineModel);
  }
  @override
  Future<List<AddMedicineModel>> retrieveMedicine() {
    return service.retrieveAllMedicine();
  }

  @override
  Future<void> editMedicine(AddMedicineModel addMedicineModel,docId){
    return service.updateMedicine(addMedicineModel,docId);
  }
  @override
  Future<void> deleteMedicine(AddMedicineModel addMedicineModel,docId){
    return service.deleteMedRecord(addMedicineModel, docId);
  }

}

abstract class DatabaseRepository{
  Future<void> addMedicine(AddMedicineModel addMedicineModel);
  Future<List<AddMedicineModel>> retrieveMedicine();
  Future<void> editMedicine(AddMedicineModel addMedicineModel,docId);
  Future<void> deleteMedicine(AddMedicineModel addMedicineModel,docId);
}