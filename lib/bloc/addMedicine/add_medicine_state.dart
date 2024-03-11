part of 'add_medicine_bloc.dart';

 abstract class AddMedicineState extends Equatable{

   const AddMedicineState();

  @override
  List<Object> get props => [];
}

class GetMedicineState extends AddMedicineState{
   GetMedicineState({required this.medicineData});
   List<AddMedicineModel> medicineData;

   @override
  List<Object> get props => [medicineData];
}
class AddMedicineInitialState extends AddMedicineState {}

class AddMedicineFormValidState extends AddMedicineState{}

class AddMedicineLoadingState extends AddMedicineState {}

class AddMedicineSuccessState extends AddMedicineState {}

class AddMedicineErrorState extends AddMedicineState {
  final String error;

  const AddMedicineErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class AddMedicineNameInvalidState extends AddMedicineState {
  final String error;
  const AddMedicineNameInvalidState({required this.error});

  @override
  List<Object> get props => [error];
}

class AddMedicineDescriptionInvalidState extends AddMedicineState {
  final String error;

  const AddMedicineDescriptionInvalidState({required this.error});
}

class AddMedicineManufacturerInvalidState extends AddMedicineState {
  final String error;

  const AddMedicineManufacturerInvalidState({required this.error});
}

class AddMedicineDosageInvalidState extends AddMedicineState {
  final String error;

  const AddMedicineDosageInvalidState({required this.error});
}

class AddMedicineStrengthInvalidState extends AddMedicineState {
  final String error;

  const AddMedicineStrengthInvalidState({required this.error});
}

class AddMedicineUsageInfoInvalidState extends AddMedicineState {
  final String error;

  const AddMedicineUsageInfoInvalidState({required this.error});
}
class AddMedicineStockQuantityInvalidState extends AddMedicineState {
  final String error;

  const AddMedicineStockQuantityInvalidState({required this.error});
}

class AddMedicineExpiryDateInvalidState extends AddMedicineState {
  final String error;

  const AddMedicineExpiryDateInvalidState({required this.error});
}

class AddMedicinePriceInvalidState extends AddMedicineState {
  final String error;

  const AddMedicinePriceInvalidState({required this.error});
}
class AddMedicineImageValidState extends AddMedicineState {}

class AddMedicineImageInvalidState extends AddMedicineState {
  final String error;

  const AddMedicineImageInvalidState({required this.error});
}
class DatePickedState extends AddMedicineState {
  final String selectedDateString;

  const DatePickedState({required this.selectedDateString});
}
class DatePickedChangedState extends AddMedicineState {
  final String newSelectedDateString;

  const DatePickedChangedState({required this.newSelectedDateString});
}
class ImagePickedState extends AddMedicineState {
  final XFile imageFile;

 const  ImagePickedState({required this.imageFile}) ;

  @override
  List<Object> get props => [imageFile];
}

class ImagePickerErrorState extends AddMedicineState {
  final String errorMessage;

   const ImagePickerErrorState(this.errorMessage);
}

class AddMedicineClearFormState extends AddMedicineState {}

class MedDeleteRecordSuccessState extends AddMedicineState{}

class MedicineTypeSelectedState extends AddMedicineState{
   final String selectedMedicineType;

   MedicineTypeSelectedState({required this.selectedMedicineType});

   @override
   List<String> get props => [selectedMedicineType];

}
