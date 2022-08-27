class ServicesModel {
  late bool status;
  late String massege;
  DataModelList? data;
  ServicesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    massege = json['massege'];
    data = json['data'] != null ? DataModelList.fromJson(json['data']) : null;
  }
}

class DataModelList {
  List<DataModel> servicesList = [];
  DataModelList.fromJson(List<dynamic> list) {
    list.forEach((element) {
       servicesList.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String serName;
  late int value;
  late String description;
  late String image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serName = json['ser_name'];
    value = json['value'];
    description = json['description'];
    image = json['Image'];
  }
}
