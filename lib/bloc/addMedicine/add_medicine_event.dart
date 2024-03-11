part of 'add_medicine_bloc.dart';

abstract class AddMedicineEvent {
  const AddMedicineEvent();
}

class MedicineImagePickedEvent extends AddMedicineEvent {
  final XFile imageFile;

  MedicineImagePickedEvent({required this.imageFile});
}

class MedicineDatePickedEvent extends AddMedicineEvent {
  final String selectedDateString;

  MedicineDatePickedEvent({required this.selectedDateString});
}

class MedicineFieldChangedEvent extends AddMedicineEvent {
  final AddMedicineModel addMedicineModel;

  MedicineFieldChangedEvent({required this.addMedicineModel,});
}

class MedicineSubmitFormEvent extends AddMedicineEvent {
  final AddMedicineModel addMedicineModel;

  MedicineSubmitFormEvent({required this.addMedicineModel,});
}

class MedicineEditEvent extends AddMedicineEvent{
  final AddMedicineModel addMedicineModel;

  MedicineEditEvent({required this.addMedicineModel});
}

class MedDeleteEvent extends AddMedicineEvent{
  final AddMedicineModel addMedicineModel;

  MedDeleteEvent({required this.addMedicineModel});
}

class GetMedicineData extends AddMedicineEvent{}

class MedicineTypeSelectEvent extends AddMedicineEvent{
  final String? selectedMedicineType;

  MedicineTypeSelectEvent({required this.selectedMedicineType});
}
