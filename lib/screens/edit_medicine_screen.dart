import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../data model/AddMedicineModel.dart';
import '../repository/database_repository.dart';

class EditMedicineForm extends StatefulWidget {
  const EditMedicineForm({
    Key? key,
    required this.medName,
    required this.medId,
    required this.medDescription,
    required this.medPrice,
    required this.medManufacturer,
    required this.medDosageForm,
    required this.medStrength,
    required this.medUsageInfo,
    required this.medStockQuantity,
    required this.medExDate,
    required this.medImage,
    required this.selectedMedicineType,
  }) : super(key: key);

  final String medName;
  final String medId;
  final String medDescription;
  final String medPrice;
  final String medManufacturer;
  final String medDosageForm;
  final String medStrength;
  final String medUsageInfo;
  final String medStockQuantity;
  final String medExDate;
  final String medImage;
  final String selectedMedicineType;

  @override
  State<EditMedicineForm> createState() => _EditMedicineFormState();
}

class _EditMedicineFormState extends State<EditMedicineForm> {
  final List<String> medicineTypes = [
    'Fever',
    'Cold',
    'Headache',
    'Allergy',
    'Pain',
    'Cough',
    'Digestion',
    'Infection',
    'Others',
  ];

  DateTime selectedDate = DateTime.now();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? pickedFile;
  String? formattedDate;

  late TextEditingController _medicineNameController;
  late TextEditingController _medicineDescriptionController;
  late TextEditingController _manufacturerController;
  late TextEditingController _dosageFormController;
  late TextEditingController _strengthController;
  late TextEditingController _usageInformationController;
  late TextEditingController _stockQuantityController;
  late TextEditingController _expiryDateController;
  late TextEditingController _priceController;
  late String selectedMedicineType;
  late String uid;

  @override
  void initState() {
    super.initState();
    uid = widget.medId;
    selectedMedicineType = widget.selectedMedicineType;
    _medicineNameController = TextEditingController(text: widget.medName);
    _medicineDescriptionController =
        TextEditingController(text: widget.medDescription);
    _manufacturerController =
        TextEditingController(text: widget.medManufacturer);
    _dosageFormController = TextEditingController(text: widget.medDosageForm);
    _strengthController = TextEditingController(text: widget.medStrength);
    _usageInformationController =
        TextEditingController(text: widget.medUsageInfo);
    _stockQuantityController =
        TextEditingController(text: widget.medStockQuantity);
    _expiryDateController = TextEditingController(text: widget.medExDate);
    _priceController = TextEditingController(text: widget.medPrice);
  }

  @override
  void dispose() {
    _medicineNameController.dispose();
    _medicineDescriptionController.dispose();
    _manufacturerController.dispose();
    _dosageFormController.dispose();
    _strengthController.dispose();
    _usageInformationController.dispose();
    _stockQuantityController.dispose();
    _expiryDateController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Medicine'),
      ),
      body: _buildForm(context),
    );
  }

  Widget _buildForm(BuildContext context) {
    return ListView(
      children: [
        Form(
          child: Column(
            children: [
              _buildTextWidget(
                controller: _medicineNameController,
                label: 'Medicine Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter medicine name';
                  }
                  return null;
                },
              ),
              _buildDropdownWidget(),
              _buildTextWidget(
                controller: _medicineDescriptionController,
                label: 'Medicine Description',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter medicine description';
                  }
                  return null;
                },
              ),
              _buildTextWidget(
                controller: _manufacturerController,
                label: 'Manufacturer',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter manufacturer';
                  }
                  return null;
                },
              ),
              _buildTextWidget(
                controller: _dosageFormController,
                label: 'Dosage Form',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter dosage form';
                  }
                  return null;
                },
              ),
              _buildTextWidget(
                controller: _strengthController,
                label: 'Strength',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter strength';
                  }
                  return null;
                },
              ),
              _buildTextWidget(
                controller: _usageInformationController,
                label: 'Usage Information',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter usage information';
                  }
                  return null;
                },
              ),
              _buildTextWidget(
                controller: _stockQuantityController,
                label: 'Stock Quantity',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
              ),
              _buildTextWidget(
                controller: _priceController,
                label: 'Price',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onTap: _selectDate,
                  controller: _expiryDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    prefixIcon: Icon(Icons.calendar_month_rounded),
                    labelText: 'Expiry Date',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _getImage,
                child: const Text('Pick Image'),
              ),
              _buildImageWidget(),
              ElevatedButton(
                onPressed: _editWidget,
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text(
            "Medicine Type :-     ",
            style: TextStyle(fontSize: 17),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                alignment: Alignment.center,
                value: selectedMedicineType,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedMedicineType = newValue;
                    });
                  }
                },
                items:
                    medicineTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget() {
    if (pickedFile != null) {
      return Image.file(File(pickedFile!.path));
    } else if (widget.medImage != null) {
      return Image.network(widget.medImage);
    } else {
      return const Text('No Image Selected');
    }
  }

  Widget _buildTextWidget({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator, // Validator function added
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              errorText: validator != null
                  ? validator(controller.text)
                  : null, // Validation added here
            ),
            keyboardType: keyboardType,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Future<void> _getImage() async {
    pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {}
  }

  void _editWidget() async {
    if (_validateForm()) {
      String uidPhoto = const Uuid().v4();
      if (pickedFile != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('medicineImage')
            .child('$uidPhoto.jpg');
        await storageRef.putFile(File(pickedFile!.path));
        final medImgUrl = await storageRef.getDownloadURL();
        final uid = widget.medId;
        print(uid);
        FirebaseFirestore.instance.collection("medicineDetails").doc(uid).set(
            AddMedicineModel(
              uid: uid,
                name: _medicineNameController.text,
                description: _medicineDescriptionController.text,
                dosageForm: _dosageFormController.text,
                expiryDate: _expiryDateController.text,
                manufacturer: _manufacturerController.text,
                price: double.parse(_priceController.text),
                productImage: medImgUrl,
                stockQuantity: double.parse(_stockQuantityController.text),
                strength: _strengthController.text,
                usageInformation: _usageInformationController.text,
                medicineType: selectedMedicineType) as Map<String, dynamic>);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Data successfully edited',
              style: TextStyle(color: Colors.black),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        final db = DatabaseRepositoryImplement();
        final uid = widget.medId;
        print(uid);
        db.editMedicine(
            AddMedicineModel().copyWith(
              uid: uid,

                name: _medicineNameController.text,
                description: _medicineDescriptionController.text,
                dosageForm: _dosageFormController.text,
                expiryDate: _expiryDateController.text,
                manufacturer: _manufacturerController.text,
                price: double.parse(_priceController.text),
                productImage: widget.medImage,
                stockQuantity: double.parse(_stockQuantityController.text),
                strength: _strengthController.text,
                usageInformation: _usageInformationController.text,
                medicineType: selectedMedicineType),
            uid);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Data successfully edited',
              style: TextStyle(color: Colors.black),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  bool _validateForm() {
    if (_medicineNameController.text.isEmpty) {
      _showErrorSnackBar('Please enter medicine name');
      return false;
    } else if (_medicineDescriptionController.text.isEmpty) {
      _showErrorSnackBar('Please enter medicine description');
      return false;
    } else if (_manufacturerController.text.isEmpty) {
      _showErrorSnackBar('Please enter manufacturer');
      return false;
    } else if (_dosageFormController.text.isEmpty) {
      _showErrorSnackBar('Please enter dosage form');
      return false;
    } else if (_strengthController.text.isEmpty) {
      _showErrorSnackBar('Please enter strength');
      return false;
    } else if (_usageInformationController.text.isEmpty) {
      _showErrorSnackBar('Please enter usage information');
      return false;
    } else if (_stockQuantityController.text.isEmpty) {
      _showErrorSnackBar('Please enter stock quantity');
      return false;
    } else if (_priceController.text.isEmpty) {
      _showErrorSnackBar('Please enter price');
      return false;
    }
    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      initialDate: selectedDate,
    );
    if (picked != null && picked != selectedDate) {
      DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      _expiryDateController.text = dateFormat.format(picked);
      print(formattedDate);
      setState(() {});
    }
  }
}
