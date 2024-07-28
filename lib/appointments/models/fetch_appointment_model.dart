/*
class AppointmentList{
  int? id;
  String? name;
  String? contact;
  String? abhaNumber;
  String? aadharNumber;
  String? paymentStatus;
  String? appointmentvisitStatus;
  int? age;
  String? gender;
  String? appointmentDate;
  String? appointmentTime;
  String? clinicLocation;
  Null clinic;

}*/

class AppointmentList {
  List<Data>? data;
  int? statusCode;
  String? message;

  AppointmentList({this.data, this.statusCode, this.message});

  AppointmentList.fromJson(Map<String, dynamic> json) {
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
  Null aadharNumber;
  String? paymentStatus;
  String? appointmentvisitStatus;
  int? age;
  String? gender;
  String? appointmentDate;
  String? appointmentTime;
  String? clinicLocation;
  Null clinic;

  Data(
      {this.id,
        this.name,
        this.contact,
        this.abhaNumber,
        this.aadharNumber,
        this.paymentStatus,
        this.appointmentvisitStatus,
        this.age,
        this.gender,
        this.appointmentDate,
        this.appointmentTime,
        this.clinicLocation,
        this.clinic});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    abhaNumber = json['abhaNumber'];
    aadharNumber = json['aadharNumber'];
    paymentStatus = json['paymentStatus'];
    appointmentvisitStatus = json['appointmentvisitStatus'];
    age = json['age'];
    gender = json['gender'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    clinicLocation = json['clinicLocation'];
    clinic = json['clinic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['abhaNumber'] = this.abhaNumber;
    data['aadharNumber'] = this.aadharNumber;
    data['paymentStatus'] = this.paymentStatus;
    data['appointmentvisitStatus'] = this.appointmentvisitStatus;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentTime'] = this.appointmentTime;
    data['clinicLocation'] = this.clinicLocation;
    data['clinic'] = this.clinic;
    return data;
  }
}

