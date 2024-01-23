import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../data model/AddMedicineModel.dart';
part 'add_medicine_state.dart';

part 'add_medicine_event.dart';


class AddMedicineBloc extends Bloc<AddMedicineEvent, AddMedicineState> {

  AddMedicineBloc() : super(AddMedicineInitialState()) {
    on<MedicineImagePickedEvent>((event, emit) {
      emit(ImagePickedState(imageFile: event.imageFile));

      print('State: ImagePickedState');
    });
    on<MedicineSubmitFormEvent>((event, emit) async{
      String uid = const Uuid().v4();
      // try{
      //   emit(AddMedicineLoadingState());
      //   if (_image != null) {
      //     final storageRef = FirebaseStorage.instance.ref().child('medicineImage').child('$uid.jpg');
      //     await storageRef.putFile(_image! as File);
      //     final medImgUrl = await storageRef.getDownloadURL();
      //   }}catch(e){
      //   print('$e');
      //   emit(AddMedicineErrorState(error: 'An error occurred while submitting the form'));
      // }
    });
    on<MedicineChangeEvent>((event, emit) {
      if (event.addMedicineModel.name!.isEmpty) {
        emit(AddMedicineNameInvalidState(error: 'Please enter the medicine name'));
      } else if (event.addMedicineModel.description!.isEmpty) {
        emit(AddMedicineDescriptionInvalidState(error: 'Please enter the medicine description'));
      } else if (event.addMedicineModel.manufacturer!.isEmpty) {
        emit(AddMedicineManufacturerInvalidState(error: 'Please enter the manufacturer'));
      } else if (event.addMedicineModel.dosageForm!.isEmpty) {
        emit(AddMedicineDosageInvalidState(error: 'Please enter the dosage'));
      } else if (event.addMedicineModel.strength!.isEmpty) {
        emit(AddMedicineStrengthInvalidState(error: 'Please enter the strength'));
      } else if (event.addMedicineModel.usageInformation!.isEmpty) {
        emit(AddMedicineUsageInfoInvalidState(error: 'Please enter the usage information'));
      }else if (event.addMedicineModel.stockQuantity!.isNaN) {
        emit(AddMedicineStockQuantityInvalidState(error: 'Please enter the usage information'));
      }else if (event.addMedicineModel.expiryDate!.isEmpty) {
        emit(AddMedicinePriceInvalidState(error: 'Please enter the usage information'));
      }else if (event.addMedicineModel.price!.isNaN) {
        emit(AddMedicineExpiryDateInvalidState(error: 'Please enter the usage information'));
      }else{
        emit(AddMedicineSuccessState());
      }
    });
  }
}


