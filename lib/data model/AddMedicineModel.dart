import 'package:cloud_firestore/cloud_firestore.dart' show DocumentSnapshot;

class AddMedicineModel {
  String? uid;
  String? name;
  String? description;
  String? manufacturer;
  String? dosageForm;
  String? strength;
  num? stockQuantity;
  String? expiryDate;
  num? price;
  String? usageInformation;
  String? productImage;
  String? medicineType; // New field

  AddMedicineModel({
    this.uid,
    this.name,
    this.description,
    this.manufacturer,
    this.dosageForm,
    this.strength,
    this.stockQuantity,
    this.expiryDate,
    this.price,
    this.usageInformation,
    this.productImage,
    this.medicineType,
  });

  Map<String, dynamic> toMap() {
    return {
      'medicineName': name,
      'medDescription': description,
      'manufacturer': manufacturer,
      'dosageForm': dosageForm,
      'strength': strength,
      'stockQuantity': stockQuantity,
      'expiryDate': expiryDate,
      'price': price,
      'useInfo': usageInformation,
      'medImage': productImage,
      'medicineType': medicineType, // Add to the map
    };
  }

  AddMedicineModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        name = doc.data()?['medicineName'],
        productImage = doc.data()?['medImage'],
        price = doc.data()?['price'],
        usageInformation = doc.data()?['useInfo'],
        expiryDate = doc.data()?['expiryDate'],
        stockQuantity = doc.data()?['stockQuantity'],
        strength = doc.data()?['strength'],
        dosageForm = doc.data()?['dosageForm'],
        manufacturer = doc.data()?['manufacturer'],
        description = doc.data()?['medDescription'],
        medicineType = doc.data()?['medicineType']; // Assign medicineType

  AddMedicineModel copyWith({
    String? uid,
    String? name,
    String? description,
    String? manufacturer,
    String? dosageForm,
    String? strength,
    num? stockQuantity,
    String? expiryDate,
    num? price,
    String? usageInformation,
    String? productImage,
    String? medicineType,
  }) {
    return AddMedicineModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      description: description ?? this.description,
      manufacturer: manufacturer ?? this.manufacturer,
      dosageForm: dosageForm ?? this.dosageForm,
      strength: strength ?? this.strength,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      expiryDate: expiryDate ?? this.expiryDate,
      price: price ?? this.price,
      usageInformation: usageInformation ?? this.usageInformation,
      productImage: productImage ?? this.productImage,
      medicineType: medicineType ?? this.medicineType, // Update medicineType
    );
  }
}
