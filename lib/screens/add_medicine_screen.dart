import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../bloc/addMedicine/add_medicine_bloc.dart';
import '../data model/AddMedicineModel.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  String selectedMedicineType = 'Fever';

  DateTime selectedDate = DateTime.now();

  final ImagePicker _imagePicker = ImagePicker();

  XFile? pickedFile;

  void _onFieldChanged() {
    AddMedicineModel formModel = AddMedicineModel(
      name: _medicineNameController.text,
      description: _medicineDescriptionController.text,
      manufacturer: _manufacturerController.text,
      dosageForm: _dosageFormController.text,
      strength: _strengthController.text,
      usageInformation: _usageInformationController.text,
      stockQuantity: int.tryParse(_stockQuantityController.text) ?? 0,
      expiryDate: _expiryDateController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      productImage: pickedFile?.path,
      medicineType: selectedMedicineType,
    );
    BlocProvider.of<AddMedicineBloc>(context)
        .add(MedicineFieldChangedEvent(addMedicineModel: formModel));
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
      String formattedDate = dateFormat.format(picked);
      BlocProvider.of<AddMedicineBloc>(context)
          .add(MedicineDatePickedEvent(selectedDateString: formattedDate));
    }
  }

  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _medicineDescriptionController =
      TextEditingController();
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _dosageFormController = TextEditingController();
  final TextEditingController _strengthController = TextEditingController();
  final TextEditingController _usageInformationController =
      TextEditingController();
  final TextEditingController _stockQuantityController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddMedicineBloc, AddMedicineState>(
            listener: (context, state) {
              if (state is AddMedicineClearFormState) {
                _medicineNameController.clear();
                _medicineDescriptionController.clear();
                _manufacturerController.clear();
                _dosageFormController.clear();
                _strengthController.clear();
                _usageInformationController.clear();
                _stockQuantityController.clear();
                _expiryDateController.clear();
                _priceController.clear();
                pickedFile = null;
              } else if (state is AddMedicineSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data successfully edited',
                        style: TextStyle(color: Colors.black)),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
        child: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return BlocBuilder<AddMedicineBloc, AddMedicineState>(
      builder: (context, state) {
        if (state is AddMedicineLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextWidget(
                      controller: _medicineNameController,
                      label: 'Medicine Name',
                      fieldName: 'medicineName',
                    ),
                    _buildDropdownWidget(),
                    _buildTextWidget(
                      controller: _medicineDescriptionController,
                      label: 'Medicine Description',
                      fieldName: 'medicineDescription',
                    ),
                    _buildTextWidget(
                      controller: _manufacturerController,
                      label: 'Manufacturer',
                      fieldName: 'manufacturer',
                    ),
                    _buildTextWidget(
                      controller: _dosageFormController,
                      label: 'Dosage Form',
                      fieldName: 'dosageForm',
                    ),
                    _buildTextWidget(
                        controller: _strengthController,
                        label: 'Strength',
                        fieldName: 'strength',
                        keyboardType: TextInputType.number),
                    _buildTextWidget(
                      controller: _usageInformationController,
                      label: 'Usage Information',
                      fieldName: 'usageInformation',
                    ),
                    _buildTextWidget(
                      controller: _stockQuantityController,
                      label: 'Stock Quantity',
                      fieldName: 'stockQuantity',
                      keyboardType: TextInputType.number,
                    ),
                    _buildTextWidget(
                      controller: _priceController,
                      label: 'Price',
                      fieldName: 'price',
                      keyboardType: TextInputType.number,
                    ),
                    BlocBuilder<AddMedicineBloc, AddMedicineState>(
                      builder: (context, state) {
                        if (state is DatePickedState) {
                          _expiryDateController.text = state.selectedDateString;
                        } else if (state is DatePickedChangedState) {
                          _expiryDateController.text =
                              state.newSelectedDateString;
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onTap: _selectDate,
                            controller: _expiryDateController,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              prefixIcon: Icon(Icons.calendar_month_rounded),
                              label: Text(
                                'Expiry Date',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: _getImage,
                      child: const Text('Pick Image'),
                    ),
                    BlocBuilder<AddMedicineBloc, AddMedicineState>(
                      builder: (context, state) {
                        if (state is ImagePickedState) {
                          final imageFile = state.imageFile;
                          return Image.file(File(imageFile.path));
                        }else {
                          return const Text('No Image Selected');
                        }
                      },
                    ),
                    BlocBuilder<AddMedicineBloc, AddMedicineState>(
                      builder: (context, state) {
                        if (state is AddMedicineErrorState) {
                          return Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocListener<AddMedicineBloc, AddMedicineState>(
                      listener: (context, state) {
                        if (state is AddMedicineFormValidState) {
                          AddMedicineModel formModel = AddMedicineModel(
                            name: _medicineNameController.text,
                            description: _medicineDescriptionController.text,
                            manufacturer: _manufacturerController.text,
                            dosageForm: _dosageFormController.text,
                            strength: _strengthController.text,
                            usageInformation: _usageInformationController.text,
                            stockQuantity:
                                int.tryParse(_stockQuantityController.text) ??
                                    0,
                            expiryDate: _expiryDateController.text,
                            price:
                                double.tryParse(_priceController.text) ?? 0.0,
                            productImage: pickedFile!.path,
                            medicineType: selectedMedicineType
                          );
                          BlocProvider.of<AddMedicineBloc>(context).add(
                              MedicineSubmitFormEvent(
                                  addMedicineModel: formModel));
                        }
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          _onFieldChanged();
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildDropdownWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Text("Medicine Type :-     " ,style: TextStyle(fontSize: 17)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AddMedicineBloc, AddMedicineState>(
                builder: (context, state) {
                  if (state is MedicineTypeSelectedState) {
                    return DropdownButton<String>(
                      alignment: Alignment.center,
                      value: state.selectedMedicineType,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          selectedMedicineType = newValue;
                          _onMedicineTypeSelectedChanged(newValue);
                          print(selectedMedicineType);
                        }
                      },
                      items:
                          medicineTypes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  } else {
                    return DropdownButton<String>(
                      value: selectedMedicineType,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          _onMedicineTypeSelectedChanged(newValue);
                          print(selectedMedicineType);
                        }
                      },
                      items:
                          medicineTypes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextWidget({
    required TextEditingController controller,
    required String label,
    required String fieldName,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
            keyboardType: keyboardType,
            onChanged: (value) {
              _onFieldChanged();
            },
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Future<void> _getImage() async {
    pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      BlocProvider.of<AddMedicineBloc>(context)
          .add(MedicineImagePickedEvent(imageFile: pickedFile!));
    }
  }

  void _onMedicineTypeSelectedChanged(String selectedMedicineType) {
    BlocProvider.of<AddMedicineBloc>(context).add(
        MedicineTypeSelectEvent(selectedMedicineType: selectedMedicineType));
  }
}
