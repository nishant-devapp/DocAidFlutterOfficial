class AbhaPhonePatientModel {
  List<Data>? data;
  int? statusCode;
  String? message;

  AbhaPhonePatientModel({this.data, this.statusCode, this.message});

  AbhaPhonePatientModel.fromJson(Map<String, dynamic> json) {
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
  String? paymentStatus;
  String? abhaNumber;
  int? age;
  String? gender;
  String? appointmentDate;
  String? appointmentTime;
  String? clinicLocation;
  String? address;
  String? guardianName;

  Data(
      {this.id,
        this.name,
        this.contact,
        this.paymentStatus,
        this.abhaNumber,
        this.age,
        this.gender,
        this.appointmentDate,
        this.appointmentTime,
        this.clinicLocation,
        this.address,
        this.guardianName,
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    paymentStatus = json['paymentStatus'];
    abhaNumber = json['abhaNumber'];
    age = json['age'];
    gender = json['gender'];
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    clinicLocation = json['clinicLocation'];
    address = json['address'];
    guardianName = json['guardianName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['paymentStatus'] = this.paymentStatus;
    data['abhaNumber'] = this.abhaNumber;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentTime'] = this.appointmentTime;
    data['clinicLocation'] = this.clinicLocation;
    data['address'] = this.address;
    data['guardianName'] = this.guardianName;
    return data;
  }
}

// class Doctor {
//   int? id;
//   String? firstName;
//   String? lastName;
//   List<String>? specialization;
//   List<String>? degree;
//   int? experience;
//   List<String>? researchJournal;
//   List<String>? citations;
//   List<String>? achievements;
//   String? licenceNumber;
//   String? contact;
//   String? email;
//   String? password;
//
//   Doctor(
//       {this.id,
//         this.firstName,
//         this.lastName,
//         this.specialization,
//         this.degree,
//         this.experience,
//         this.researchJournal,
//         this.citations,
//         this.achievements,
//         this.licenceNumber,
//         this.contact,
//         this.email,
//         this.password,
//       });
//
//   Doctor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     specialization = json['specialization'].cast<String>();
//     degree = json['degree'].cast<String>();
//     experience = json['experience'];
//     researchJournal = json['research_journal'].cast<String>();
//     citations = json['citations'].cast<String>();
//     achievements = json['achievements'].cast<String>();
//     licenceNumber = json['licenceNumber'];
//     contact = json['contact'];
//     email = json['email'];
//     password = json['password'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['specialization'] = this.specialization;
//     data['degree'] = this.degree;
//     data['experience'] = this.experience;
//     data['research_journal'] = this.researchJournal;
//     data['citations'] = this.citations;
//     data['achievements'] = this.achievements;
//     data['licenceNumber'] = this.licenceNumber;
//     data['contact'] = this.contact;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     return data;
//   }
// }
//
// class AppointmentDto {
//   int? id;
//   String? name;
//   String? contact;
//   String? abhaNumber;
//   String? paymentStatus;
//   String? appointmentvisitStatus;
//   int? age;
//   String? gender;
//   String? appointmentDate;
//   String? appointmentTime;
//   String? clinicLocation;
//
//   AppointmentDto(
//       {this.id,
//         this.name,
//         this.contact,
//         this.abhaNumber,
//         this.paymentStatus,
//         this.appointmentvisitStatus,
//         this.age,
//         this.gender,
//         this.appointmentDate,
//         this.appointmentTime,
//         this.clinicLocation,
//       });
//
//   AppointmentDto.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     contact = json['contact'];
//     abhaNumber = json['abhaNumber'];
//     paymentStatus = json['paymentStatus'];
//     appointmentvisitStatus = json['appointmentvisitStatus'];
//     age = json['age'];
//     gender = json['gender'];
//     appointmentDate = json['appointmentDate'];
//     appointmentTime = json['appointmentTime'];
//     clinicLocation = json['clinicLocation'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['contact'] = this.contact;
//     data['abhaNumber'] = this.abhaNumber;
//     data['paymentStatus'] = this.paymentStatus;
//     data['appointmentvisitStatus'] = this.appointmentvisitStatus;
//     data['age'] = this.age;
//     data['gender'] = this.gender;
//     data['appointmentDate'] = this.appointmentDate;
//     data['appointmentTime'] = this.appointmentTime;
//     data['clinicLocation'] = this.clinicLocation;
//     return data;
//   }
// }
