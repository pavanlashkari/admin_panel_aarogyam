part of 'add_medicine_bloc.dart';

abstract class AddMedicineEvent {
  const AddMedicineEvent();

  @override
  List<Object> get props => [];
}

class MedicineImagePickedEvent extends AddMedicineEvent {
  final XFile imageFile;

  MedicineImagePickedEvent({required this.imageFile});
}


class MedicineChangeEvent extends AddMedicineEvent {
  MedicineChangeEvent({
    required this.addMedicineModel,
  });

  AddMedicineModel addMedicineModel;
}

class MedicineSubmitFormEvent extends AddMedicineEvent {
  MedicineSubmitFormEvent({
    required this.addMedicineModel,
  });

  AddMedicineModel addMedicineModel;
}
