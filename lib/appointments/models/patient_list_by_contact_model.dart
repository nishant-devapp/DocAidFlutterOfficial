class ContactPatientDetailModel {
  List<Data>? data;
  int? statusCode;
  String? message;

  ContactPatientDetailModel({this.data, this.statusCode, this.message});

  ContactPatientDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
