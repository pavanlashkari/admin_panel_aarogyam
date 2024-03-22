import 'dart:io';
import 'package:admin_panel_aarogyam/repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../data model/AddMedicineModel.dart';

part 'add_medicine_state.dart';

part 'add_medicine_event.dart';

class AddMedicineBloc extends Bloc<AddMedicineEvent, AddMedicineState> {
  void _validateForm(
      AddMedicineModel formModel, Emitter<AddMedicineState> emit) {
    List<String> errors = [];

    if (formModel.name == null ||
        formModel.name!.isEmpty ||
        formModel.name!.trim().isEmpty) {
      errors.add('Please enter a valid medicine name ');
    }

    if (formModel.description == null ||
        formModel.description!.isEmpty ||
        formModel.description!.length < 50) {
      errors.add('Description must be at least 50 characters long.');
    }

    if (formModel.manufacturer == null || formModel.manufacturer!.isEmpty) {
      errors.add('Please enter the manufacturer.');
    }

    if (formModel.dosageForm == null || formModel.dosageForm!.isEmpty) {
      errors.add('Please enter the dosage form.');
    }

    if (formModel.strength == null || formModel.strength!.isEmpty) {
      errors.add('Please enter the strength.');
    }

    if (formModel.usageInformation == null ||
        formModel.usageInformation!.isEmpty ||
        formModel.usageInformation!.length < 30) {
      errors.add('Usage information must be at least 30 characters long.');
    }

    if (formModel.stockQuantity == null || formModel.stockQuantity! <= 0) {
      errors.add('Please enter a valid stock quantity.');
    }

    if (formModel.expiryDate == null || formModel.expiryDate!.isEmpty) {
      errors.add('Please enter the expiry date.');
    }

    if (formModel.price == null || formModel.price! <= 0) {
      errors.add('Please enter a valid price.');
    }

    if (formModel.productImage == null) {
      errors.add('Please select a product image.');
    }

    if (errors.isNotEmpty) {
      if (errors.isNotEmpty) {
        emit(AddMedicineErrorState(error: errors.join('\n')));
      } else {
        emit(AddMedicineFormValidState());
      }
    } else {
      emit(AddMedicineFormValidState());
    }
  }

  final db = DatabaseRepositoryImplement();

  AddMedicineBloc() : super(AddMedicineInitialState()) {

    on<MedicineTypeSelectEvent>((event, emit) {
      emit(MedicineTypeSelectedState(
          selectedMedicineType: event.selectedMedicineType!));
    });
    on<MedicineDatePickedEvent>((event, emit) {
      emit(DatePickedState(selectedDateString: event.selectedDateString));
      emit(DatePickedChangedState(
          newSelectedDateString: event.selectedDateString));
    });
    on<MedicineSubmitFormEvent>((event, emit) async {
      if (state is AddMedicineFormValidState) {
        try {
          emit(AddMedicineLoadingState());
          String uid = const Uuid().v4();
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('medicineImage')
              .child('$uid.jpg');
          await storageRef.putFile(File(event.addMedicineModel.productImage!));
          final medImgUrl = await storageRef.getDownloadURL();

          final addMedicine = AddMedicineModel();
          await db.addMedicine(addMedicine.copyWith(
              name: event.addMedicineModel.name,
              description: event.addMedicineModel.description,
              dosageForm: event.addMedicineModel.dosageForm,
              expiryDate: event.addMedicineModel.expiryDate,
              manufacturer: event.addMedicineModel.manufacturer,
              price: event.addMedicineModel.price,
              productImage: medImgUrl,
              stockQuantity: event.addMedicineModel.stockQuantity,
              strength: event.addMedicineModel.strength,
              usageInformation: event.addMedicineModel.usageInformation,
              medicineType: event.addMedicineModel.medicineType));
          emit(AddMedicineSuccessState());
          emit(AddMedicineClearFormState());
        } catch (e) {
          emit(const AddMedicineErrorState(
              error: 'An error occurred while submitting the form'));
          emit(AddMedicineClearFormState());
        }
      }
    });
    on<MedDeleteEvent>((event, emit) async{
      try{
        db.deleteMedicine(event.addMedicineModel, event.addMedicineModel.uid);
        emit(MedDeleteRecordSuccessState());
      }catch(e){
        print(e.toString());
      }
    });
    on<MedicineEditEvent>((event, emit) async {
      if (state is AddMedicineFormValidState) {
        try {
          emit(AddMedicineLoadingState());
          String uidPhoto = const Uuid().v4();
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('medicineImage')
              .child('$uidPhoto.jpg');
          await storageRef.putFile(File(event.addMedicineModel.productImage!));
          final medImgUrl = await storageRef.getDownloadURL();
          final uid = event.addMedicineModel.uid;
          db.editMedicine(AddMedicineModel().copyWith(name: event.addMedicineModel.name,
              description: event.addMedicineModel.description,
              dosageForm: event.addMedicineModel.dosageForm,
              expiryDate: event.addMedicineModel.expiryDate,
              manufacturer: event.addMedicineModel.manufacturer,
              price: event.addMedicineModel.price,
              productImage: medImgUrl,
              stockQuantity: event.addMedicineModel.stockQuantity,
              strength: event.addMedicineModel.strength,
              usageInformation: event.addMedicineModel.usageInformation,
              medicineType: event.addMedicineModel.medicineType),uid);
          emit(EditMedicineSuccessState());
        } catch (e) {
          print(e.toString());
        }
      }
    });
    on<MedicineFieldChangedEvent>((event, emit) async {
      _validateForm(event.addMedicineModel, emit);
    });
    on<MedicineImagePickedEvent>((event, emit) {
      emit(ImagePickedState(imageFile: event.imageFile));
    });
    on<GetMedicineData>((event, emit) async {
      emit(AddMedicineLoadingState());
      try {
        final data = await db.retrieveMedicine();
        emit(GetMedicineState(medicineData: data));
      } catch (ex) {
        emit(AddMedicineErrorState(error: ex.toString()));
      }
    });
  }
}
