import 'package:admin_panel_aarogyam/data%20model/AddMedicineModel.dart';
import 'package:admin_panel_aarogyam/screens/edit_medicine_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/addMedicine/add_medicine_bloc.dart';

class EditDeleteScreen extends StatefulWidget {
  const EditDeleteScreen({super.key});

  @override
  State<EditDeleteScreen> createState() => _EditDeleteScreenState();
}

class _EditDeleteScreenState extends State<EditDeleteScreen> {
  @override
  void initState() {
    super.initState();

    final addMedicineBloc = BlocProvider.of<AddMedicineBloc>(context);
    addMedicineBloc.add(GetMedicineData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Screen"),
      ),
      body: BlocConsumer<AddMedicineBloc, AddMedicineState>(
        listener: (context, state) {
          if (state is MedDeleteRecordSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data successfully deleted',
                    style: TextStyle(color: Colors.black)),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
            BlocProvider.of<AddMedicineBloc>(context).add(GetMedicineData());
          }
        },
        builder: (context, state) {
          if (state is GetMedicineState) {
            return ListView.builder(
                itemCount: state.medicineData.length,
                itemBuilder: (context, index) {
                  final data = state.medicineData;
                  if (data[index].productImage == null) {
                    return const SizedBox();
                  }
                  return ListTile(
                   onTap: () => showDialog(
    context: context,
                     builder: (context) => AlertDialog(
                       title: const Text('Options'),
                       content: Column(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           ListTile(
                             title: const Text('Update'),
                             onTap: () {
                               Navigator.pop(context);
                               print('onTap');
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => BlocProvider(
                                     create: (context) => AddMedicineBloc(),
                                     child: EditMedicineForm(
                                       medId: data[index].uid!,
                                       medName: data[index].name!,
                                       medDescription:
                                       data[index].description!,
                                       medManufacturer:
                                       data[index].manufacturer!,
                                       medDosageForm:
                                       data[index].dosageForm!,
                                       medStrength: data[index].strength!,
                                       medUsageInfo:
                                       data[index].usageInformation!,
                                       medStockQuantity: data[index]
                                           .stockQuantity
                                           .toString(),
                                       medPrice:
                                       data[index].price.toString(),
                                       medExDate: data[index].expiryDate!,
                                       medImage: data[index].productImage!,
                                       selectedMedicineType:
                                       data[index].medicineType!,
                                     ),
                                   ),
                                 ),
                               );
                             },
                           ),
                           ListTile(
                             title: const Text('Delete'),
                             onTap: () {
                               Navigator.pop(context);
                               BlocProvider.of<AddMedicineBloc>(context).add(
                                 MedDeleteEvent(
                                   addMedicineModel: AddMedicineModel(
                                     uid: data[index].uid!,
                                     name: data[index].name!,
                                     description: data[index].description!,
                                     manufacturer: data[index].manufacturer!,
                                     dosageForm: data[index].dosageForm!,
                                     strength: data[index].strength!,
                                     usageInformation:
                                     data[index].usageInformation!,
                                     stockQuantity:
                                     data[index].stockQuantity,
                                     price: data[index].price,
                                     expiryDate: data[index].expiryDate!,
                                     productImage: data[index].productImage!,
                                     medicineType: data[index].medicineType!,
                                   ),
                                 ),
                               );
                             },
                           ),
                         ],
                       ),
                     ),
                   ),
                    title: Text(data[index].name ?? ""),
                    subtitle: Text("${data[index].price ?? 0}"),
                    leading: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.network(
                        data[index].productImage!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                });
          } else if (state is AddMedicineErrorState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is AddMedicineLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }else{
            return const SizedBox();
          }
        },
      ),
    );
  }
}
