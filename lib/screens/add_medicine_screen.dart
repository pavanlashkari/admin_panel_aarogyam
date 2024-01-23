import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/addMedicine/add_medicine_bloc.dart';

class AddMedicineScreen extends StatelessWidget {
  final AddMedicineBloc addMedicineBloc;

  AddMedicineScreen({required this.addMedicineBloc});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? _image;

  TextEditingController _medicineNameController = TextEditingController();

  TextEditingController _medicineDescriptionController =
      TextEditingController();

  TextEditingController _manufacturerController = TextEditingController();

  TextEditingController _dosageFormController = TextEditingController();

  TextEditingController _strengthController = TextEditingController();

  TextEditingController _usageInformationController = TextEditingController();

  TextEditingController _stockQuantityController = TextEditingController();

  TextEditingController _expiryDateController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _medicineNameController,
                decoration: InputDecoration(labelText: 'Medicine Name'),
              ),
              TextFormField(
                controller: _medicineDescriptionController,
                decoration: InputDecoration(labelText: 'Medicine Description'),
              ),
              TextFormField(
                controller: _manufacturerController,
                decoration: InputDecoration(labelText: 'Manufacturer'),
              ),
              TextFormField(
                controller: _dosageFormController,
                decoration: InputDecoration(labelText: 'Dosage Form'),
              ),
              TextFormField(
                controller: _strengthController,
                decoration: InputDecoration(labelText: 'Strength'),
              ),
              TextFormField(
                controller: _usageInformationController,
                decoration: InputDecoration(labelText: 'Usage Information'),
              ),
              TextFormField(
                controller: _stockQuantityController,
                decoration: InputDecoration(labelText: 'Stock Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(labelText: 'Expiry Date'),
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _getImage,
                child: const Text('Pick Image'),
              ),
              BlocBuilder<AddMedicineBloc, AddMedicineState>(
                key: UniqueKey(),
                builder: (context, state) {
                  if (state is ImagePickedState) {
                    final imageFile = state.imageFile;
                    print(imageFile.path);
                    if (imageFile != null) {
                      return Image.file(imageFile as File);
                    } else {
                      return const Text('Image File Does Not Exist');
                    }
                  } else {
                    return const Text('No Image Selected');
                  }
                },
              ),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform your form submission logic here
                    print('Medicine Name: ${_medicineNameController.text}');
                    print(
                        'Medicine Description: ${_medicineDescriptionController.text}');
                    print('Manufacturer: ${_manufacturerController.text}');
                    print('Dosage Form: ${_dosageFormController.text}');
                    print('Strength: ${_strengthController.text}');
                    print(
                        'Usage Information: ${_usageInformationController.text}');
                    print('Stock Quantity: ${_stockQuantityController.text}');
                    print('Expiry Date: ${_expiryDateController.text}');
                    print('Price: ${_priceController.text}');
                    if (_image != null) {
                      print('Image Path: ${_image!.path}');
                      // Dispatch the event to your Bloc
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _getImage() async {
    XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print(pickedFile.path);
      addMedicineBloc.add(MedicineImagePickedEvent(imageFile: pickedFile));
    }
  }

}
