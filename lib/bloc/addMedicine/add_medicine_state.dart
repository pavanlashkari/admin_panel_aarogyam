part of 'add_medicine_bloc.dart';

 abstract class AddMedicineState extends Equatable{
   const AddMedicineState();

  @override
  List<Object> get props => [];
}

class AddMedicineInitialState extends AddMedicineState {}

class AddMedicineLoadingState extends AddMedicineState {}

class AddMedicineSuccessState extends AddMedicineState {}

class AddMedicineErrorState extends AddMedicineState {
  final String error;

  AddMedicineErrorState({required this.error});
}

class AddMedicineNameInvalidState extends AddMedicineState {
  final String error;

  AddMedicineNameInvalidState({required this.error});
}

class AddMedicineDescriptionInvalidState extends AddMedicineState {
  final String error;

  AddMedicineDescriptionInvalidState({required this.error});
}

class AddMedicineManufacturerInvalidState extends AddMedicineState {
  final String error;

  AddMedicineManufacturerInvalidState({required this.error});
}

class AddMedicineDosageInvalidState extends AddMedicineState {
  final String error;

  AddMedicineDosageInvalidState({required this.error});
}

class AddMedicineStrengthInvalidState extends AddMedicineState {
  final String error;

  AddMedicineStrengthInvalidState({required this.error});
}

class AddMedicineUsageInfoInvalidState extends AddMedicineState {
  final String error;

  AddMedicineUsageInfoInvalidState({required this.error});
}
class AddMedicineStockQuantityInvalidState extends AddMedicineState {
  final String error;

  AddMedicineStockQuantityInvalidState({required this.error});
}

class AddMedicineExpiryDateInvalidState extends AddMedicineState {
  final String error;

  AddMedicineExpiryDateInvalidState({required this.error});
}

class AddMedicinePriceInvalidState extends AddMedicineState {
  final String error;

  AddMedicinePriceInvalidState({required this.error});
}
class AddMedicineImageValidState extends AddMedicineState {}

class AddMedicineImageInvalidState extends AddMedicineState {
  final String error;

  AddMedicineImageInvalidState({required this.error});
}
class ImagePickedState extends AddMedicineState {
  final XFile imageFile; // Change the type to String

 const  ImagePickedState({required this.imageFile}) ;

}
class ImagePickerErrorState extends AddMedicineState {
  final String errorMessage;

   ImagePickerErrorState(this.errorMessage);
}