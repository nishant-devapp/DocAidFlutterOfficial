class AbhaPatientDetailModel {
  Data? data;
  int? statusCode;
  String? message;

  AbhaPatientDetailModel({this.data, this.statusCode, this.message});

  AbhaPatientDetailModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? contact;
  String? abhaNumber;
  int? age;
  String? gender;
  String? address;
  String? guardianName;

  Data(
      {this.id,
        this.name,
        this.contact,
        this.abhaNumber,
        this.age,
        this.gender,
        this.address,
        this.guardianName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    abhaNumber = json['abhaNumber'];
    age = json['age'];
    gender = json['gender'];
    address = json['address'];
    guardianName = json['guardianName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['abhaNumber'] = this.abhaNumber;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['guardianName'] = this.guardianName;
    return data;
  }
}
