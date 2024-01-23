
class AddMedicineModel {
  AddMedicineModel({
      String? name, 
      String? description, 
      String? manufacturer, 
      String? dosageForm, 
      String? strength, 
      num? stockQuantity, 
      String? expiryDate, 
      num? price, 
      String? usageInformation, 
      String? productImage,}){
    _name = name;
    _description = description;
    _manufacturer = manufacturer;
    _dosageForm = dosageForm;
    _strength = strength;
    _stockQuantity = stockQuantity;
    _expiryDate = expiryDate;
    _price = price;
    _usageInformation = usageInformation;
    _productImage = productImage;
}

  AddMedicineModel.fromJson(dynamic json) {
    _name = json['name'];
    _description = json['description'];
    _manufacturer = json['manufacturer'];
    _dosageForm = json['dosageForm'];
    _strength = json['strength'];
    _stockQuantity = json['stockQuantity'];
    _expiryDate = json['expiryDate'];
    _price = json['price'];
    _usageInformation = json['usageInformation'];
    _productImage = json['productImage'];
  }
  String? _name;
  String? _description;
  String? _manufacturer;
  String? _dosageForm;
  String? _strength;
  num? _stockQuantity;
  String? _expiryDate;
  num? _price;
  String? _usageInformation;
  String? _productImage;
AddMedicineModel copyWith({  String? name,
  String? description,
  String? manufacturer,
  String? dosageForm,
  String? strength,
  num? stockQuantity,
  String? expiryDate,
  num? price,
  String? usageInformation,
  String? productImage,
}) => AddMedicineModel(  name: name ?? _name,
  description: description ?? _description,
  manufacturer: manufacturer ?? _manufacturer,
  dosageForm: dosageForm ?? _dosageForm,
  strength: strength ?? _strength,
  stockQuantity: stockQuantity ?? _stockQuantity,
  expiryDate: expiryDate ?? _expiryDate,
  price: price ?? _price,
  usageInformation: usageInformation ?? _usageInformation,
  productImage: productImage ?? _productImage,
);
  String? get name => _name;
  String? get description => _description;
  String? get manufacturer => _manufacturer;
  String? get dosageForm => _dosageForm;
  String? get strength => _strength;
  num? get stockQuantity => _stockQuantity;
  String? get expiryDate => _expiryDate;
  num? get price => _price;
  String? get usageInformation => _usageInformation;
  String? get productImage => _productImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['description'] = _description;
    map['manufacturer'] = _manufacturer;
    map['dosageForm'] = _dosageForm;
    map['strength'] = _strength;
    map['stockQuantity'] = _stockQuantity;
    map['expiryDate'] = _expiryDate;
    map['price'] = _price;
    map['usageInformation'] = _usageInformation;
    map['productImage'] = _productImage;
    return map;
  }

}