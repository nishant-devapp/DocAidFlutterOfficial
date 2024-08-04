import 'package:intl/intl.dart';

class HomeGetModel {
  Data? data;
  int? statusCode;
  String? message;

  HomeGetModel({this.data, this.statusCode, this.message});

  HomeGetModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  List<String>? degree;
  List<String>? specialization;
  int? experience;
  List<String>? researchJournal;
  List<String>? citations;
  List<String>? achievements;
  String? licenceNumber;
  String? contact;
  String? email;
  // Null password;
  List<DocIntr>? docIntr;
  // Null clinics;
  List<ClinicDtos>? clinicDtos;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.degree,
      this.specialization,
      this.experience,
      this.researchJournal,
      this.citations,
      this.achievements,
      this.licenceNumber,
      this.contact,
      this.email,
      // this.password,
      this.docIntr,
      // this.clinics,
      this.clinicDtos});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    degree = json['degree'].cast<String>();
    specialization = json['specialization'].cast<String>();
    experience = json['experience'];
    researchJournal = json['research_journal'].cast<String>();
    citations = json['citations'].cast<String>();
    achievements = json['achievements'].cast<String>();
    licenceNumber = json['licenceNumber'];
    contact = json['contact'];
    email = json['email'];
    // password = json['password'];
    if (json['docIntr'] != null) {
      docIntr = <DocIntr>[];
      json['docIntr'].forEach((v) {
        docIntr!.add(new DocIntr.fromJson(v));
      });
    }
    // clinics = json['clinics'];

    if (json['clinicDtos'] != null) {
      clinicDtos = <ClinicDtos>[];
      json['clinicDtos'].forEach((v) {
        clinicDtos!.add(new ClinicDtos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['degree'] = this.degree;
    data['specialization'] = this.specialization;
    data['experience'] = this.experience;
    data['research_journal'] = this.researchJournal;
    data['citations'] = this.citations;
    data['achievements'] = this.achievements;
    data['licenceNumber'] = this.licenceNumber;
    data['contact'] = this.contact;
    data['email'] = this.email;
    // data['password'] = this.password;
    if (this.docIntr != null) {
      data['docIntr'] = this.docIntr!.map((v) => v.toJson()).toList();
    }
    // data['clinics'] = this.clinics;
    if (this.clinicDtos != null) {
      data['clinicDtos'] = this.clinicDtos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocIntr {
  int? id;
  String? startTime;
  String? endTime;
  String? clinicName;
  String? stDate;
  String? endDate;
  String? purpose;
  int? doctorId;
  // Null clinicList;

  DocIntr({
    this.id,
    this.startTime,
    this.endTime,
    this.clinicName,
    this.stDate,
    this.endDate,
    this.purpose,
    this.doctorId,
    // this.clinicList
  });

  DocIntr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    clinicName = json['clinicName'];
    stDate = json['stDate'];
    endDate = json['endDate'];
    purpose = json['purpose'];
    doctorId = json['doctorId'];
    // clinicList = json['clinicList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['clinicName'] = this.clinicName;
    data['stDate'] = this.stDate;
    data['endDate'] = this.endDate;
    data['purpose'] = this.purpose;
    data['doctorId'] = this.doctorId;
    // data['clinicList'] = this.clinicList;
    return data;
  }
}

class ClinicDtos {
  int? id;
  String? location;
  String? incharge;
  String? clinicName;
  double? clinicNewFees;
  double? clinicOldFees;
  List<String>? days;
  // Null pincode;
  String? startTime;
  String? endTime;
  String? clinicContact;

  DateTime get parsedStartTime => DateFormat('HH:mm:ss').parse(startTime!);
  DateTime get parsedEndTime => DateFormat('HH:mm:ss').parse(endTime!);

  ClinicDtos(
      {this.id,
      this.location,
      this.incharge,
      this.clinicName,
      this.clinicNewFees,
      this.clinicOldFees,
      this.days,
      // this.pincode,
      this.startTime,
      this.endTime,
      this.clinicContact});

  ClinicDtos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    incharge = json['incharge'];
    clinicName = json['clinicName'];
    clinicNewFees = json['clinicNewFees'];
    clinicOldFees = json['clinicOldFees'];
    days = json['days'].cast<String>();
    // pincode = json['pincode'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    clinicContact = json['clinicContact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    data['incharge'] = this.incharge;
    data['clinicName'] = this.clinicName;
    data['clinicNewFees'] = this.clinicNewFees;
    data['clinicOldFees'] = this.clinicOldFees;
    data['days'] = this.days;
    // data['pincode'] = this.pincode;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['clinicContact'] = this.clinicContact;
    return data;
  }
}
