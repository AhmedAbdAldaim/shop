class ProductsModel {
  late bool status;
  late String massege;
  DataModelList? data;
  ProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    massege = json['massege'];
    data = json['data'] != null ? DataModelList.fromJson(json['data']) : null;
  }
}

class DataModelList {
  List<DataModel> productsList = [];
  DataModelList.fromJson(List<dynamic> list) {
    list.forEach((element) {
       productsList.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String spName;
  late int price;
  late String description;
  late String image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spName = json['sp_name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }
}
