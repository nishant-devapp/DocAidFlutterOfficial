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
  Null password;
  List<DocIntr>? docIntr;
  List<Clinics>? clinics;

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
        this.password,
        this.docIntr,
        this.clinics});

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
    password = json['password'];
    if (json['docIntr'] != null) {
      docIntr = <DocIntr>[];
      json['docIntr'].forEach((v) {
        docIntr!.add(new DocIntr.fromJson(v));
      });
    }
    if (json['clinics'] != null) {
      clinics = <Clinics>[];
      json['clinics'].forEach((v) {
        clinics!.add(new Clinics.fromJson(v));
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
    data['password'] = this.password;
    if (this.docIntr != null) {
      data['docIntr'] = this.docIntr!.map((v) => v.toJson()).toList();
    }
    if (this.clinics != null) {
      data['clinics'] = this.clinics!.map((v) => v.toJson()).toList();
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
  Null clinicList;

  DocIntr(
      {this.id,
        this.startTime,
        this.endTime,
        this.clinicName,
        this.stDate,
        this.endDate,
        this.purpose,
        this.doctorId,
        this.clinicList});

  DocIntr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    clinicName = json['clinicName'];
    stDate = json['stDate'];
    endDate = json['endDate'];
    purpose = json['purpose'];
    doctorId = json['doctorId'];
    clinicList = json['clinicList'];
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
    data['clinicList'] = this.clinicList;
    return data;
  }
}

class Clinics {
  int? id;
  String? location;
  String? clinicName;
  String? incharge;
  double? clinicNewFees;
  double? clinicOldFees;
  String? startTime;
  Null pincode;
  String? clinicContact;
  String? endTime;
  List<String>? days;
  List<AppointmentList>? appointmentList;
  List<AppointmentDto>? appointmentDto;

  Clinics(
      {this.id,
        this.location,
        this.clinicName,
        this.incharge,
        this.clinicNewFees,
        this.clinicOldFees,
        this.startTime,
        this.pincode,
        this.clinicContact,
        this.endTime,
        this.days,
        this.appointmentList,
        this.appointmentDto});

  Clinics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    clinicName = json['clinicName'];
    incharge = json['incharge'];
    clinicNewFees = json['clinicNewFees'];
    clinicOldFees = json['clinicOldFees'];
    startTime = json['startTime'];
    pincode = json['pincode'];
    clinicContact = json['clinicContact'];
    endTime = json['endTime'];
    days = json['days'].cast<String>();
    if (json['appointmentList'] != null) {
      appointmentList = <AppointmentList>[];
      json['appointmentList'].forEach((v) {
        appointmentList!.add(new AppointmentList.fromJson(v));
      });
    }
    if (json['appointmentDto'] != null) {
      appointmentDto = <AppointmentDto>[];
      json['appointmentDto'].forEach((v) {
        appointmentDto!.add(new AppointmentDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['location'] = this.location;
    data['clinicName'] = this.clinicName;
    data['incharge'] = this.incharge;
    data['clinicNewFees'] = this.clinicNewFees;
    data['clinicOldFees'] = this.clinicOldFees;
    data['startTime'] = this.startTime;
    data['pincode'] = this.pincode;
    data['clinicContact'] = this.clinicContact;
    data['endTime'] = this.endTime;
    data['days'] = this.days;
    if (this.appointmentList != null) {
      data['appointmentList'] =
          this.appointmentList!.map((v) => v.toJson()).toList();
    }
    if (this.appointmentDto != null) {
      data['appointmentDto'] =
          this.appointmentDto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppointmentList {
  int? id;
  String? name;
  String? contact;
  String? paymentStatus;
  String? appointmentvisitStatus;
  String? abhaNumber;
  int? age;
  String? gender;
  String? appointmentDate;
  String? appointmentTime;
  String? clinicLocation;
  Doctor? doctor;
  AppointmentDto? appointmentDto;

  AppointmentList(
      {this.id,
        this.name,
        this.contact,
        this.paymentStatus,
        this.appointmentvisitStatus,
        this.abhaNumber,
        this.age,
        this.gender,
        this.appointmentDate,
        this.appointmentTime,
        this.clinicLocation,
        this.doctor,
        this.appointmentDto});

  AppointmentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    paymentStatus = json['paymentStatus'];
    appointmentvisitStatus = json['appointmentvisitStatus'];
    abhaNumber = json['abhaNumber'];
    age = json['age'];
    gender = json['gender'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    clinicLocation = json['clinicLocation'];
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;

    appointmentDto = json['appointmentDto'] != null
        ? new AppointmentDto.fromJson(json['appointmentDto'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['paymentStatus'] = this.paymentStatus;
    data['appointmentvisitStatus'] = this.appointmentvisitStatus;
    data['abhaNumber'] = this.abhaNumber;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentTime'] = this.appointmentTime;
    data['clinicLocation'] = this.clinicLocation;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }

    if (this.appointmentDto != null) {
      data['appointmentDto'] = this.appointmentDto!.toJson();
    }
    return data;
  }
}

class Doctor {
  int? id;
  String? firstName;
  String? lastName;
  List<String>? specialization;
  List<String>? degree;
  int? experience;
  List<String>? researchJournal;
  List<String>? citations;
  List<String>? achievements;
  String? licenceNumber;
  String? contact;
  String? email;
  String? password;
  Null currentSubscriptionDetails;
  Null docIntr;

  Doctor(
      {this.id,
        this.firstName,
        this.lastName,
        this.specialization,
        this.degree,
        this.experience,
        this.researchJournal,
        this.citations,
        this.achievements,
        this.licenceNumber,
        this.contact,
        this.email,
        this.password,
        this.currentSubscriptionDetails,
        this.docIntr});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    specialization = json['specialization'].cast<String>();
    degree = json['degree'].cast<String>();
    experience = json['experience'];
    researchJournal = json['research_journal'].cast<String>();
    citations = json['citations'].cast<String>();
    achievements = json['achievements'].cast<String>();
    licenceNumber = json['licenceNumber'];
    contact = json['contact'];
    email = json['email'];
    password = json['password'];
    currentSubscriptionDetails = json['currentSubscriptionDetails'];
    docIntr = json['docIntr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['specialization'] = this.specialization;
    data['degree'] = this.degree;
    data['experience'] = this.experience;
    data['research_journal'] = this.researchJournal;
    data['citations'] = this.citations;
    data['achievements'] = this.achievements;
    data['licenceNumber'] = this.licenceNumber;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['password'] = this.password;
    data['currentSubscriptionDetails'] = this.currentSubscriptionDetails;
    data['docIntr'] = this.docIntr;
    return data;
  }
}

class AppointmentDto {
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

  AppointmentDto(
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

  AppointmentDto.fromJson(Map<String, dynamic> json) {
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
