class HomeGetModel {
  final int id;
  final String firstName;
  final String lastName;
  final List<String> degree;
  final List<String> specialization;
  final int experience;
  final List<String> researchJournal;
  final List<String> citations;
  final List<String> achievements;
  final String licenceNumber;
  final String contact;
  final String email;
  final String password;
  final List<DoctorIntr> docIntr;
  final List<Clinic> clinics;

  HomeGetModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.degree,
      required this.specialization,
      required this.experience,
      required this.researchJournal,
      required this.citations,
      required this.achievements,
      required this.licenceNumber,
      required this.contact,
      required this.email,
      required this.password,
      required this.docIntr,
      required this.clinics});

  factory HomeGetModel.fromJson(Map<String, dynamic> json) {
    return HomeGetModel(
      id: json['id'] ?? 0,
      firstName: json['firstName'],
      lastName: json['lastName'],
      degree: List<String>.from(json['degree']),
      specialization: List<String>.from(json['specialization']),
      experience: json['experience'],
      researchJournal: List<String>.from(json['research_journal']),
      citations: List<String>.from(json['citations']),
      achievements: List<String>.from(json['achievements']),
      licenceNumber: json['licenceNumber'],
      contact: json['contact'],
      email: json['email'],
      password: json['password'],
      docIntr:
          (json['docIntr'] as List).map((i) => DoctorIntr.fromJson(i)).toList(),
      clinics:
          (json['clinics'] as List).map((i) => Clinic.fromJson(i)).toList(),
    );
  }
}

class DoctorIntr {
  final int id;
  final String startTime;
  final String endTime;
  final String clinicName;
  final String stDate;
  final String endDate;
  final String purpose;
  final int doctorId;
  final List<Clinic> clinicList;

  DoctorIntr(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.clinicName,
      required this.stDate,
      required this.endDate,
      required this.purpose,
      required this.doctorId,
      required this.clinicList});

  factory DoctorIntr.fromJson(Map<String, dynamic> json) {
    return DoctorIntr(
      id: json['id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      clinicName: json['clinicName'],
      stDate: json['stDate'],
      endDate: json['endDate'],
      purpose: json['purpose'],
      doctorId: json['doctorId'],
      clinicList: (json['clinicList'] as List).map((i) => Clinic.fromJson(i)).toList(),
    );
  }
}

class Clinic {
  final int id;
  final String location;
  final String clinicName;
  final String incharge;
  final double clinicNewFees;
  final double clinicOldFees;
  final String startTime;
  final int pincode;
  final String clinicContact;
  final String endTime;
  final List<String> days;
  final List<Appointment> appointmentList;
  final List<Prescription> prescriptionList;
  final List<AppointmentDto> appointmentDto;

  Clinic({
    required this.id,
    required this.location,
    required this.clinicName,
    required this.incharge,
    required this.clinicNewFees,
    required this.clinicOldFees,
    required this.startTime,
    required this.pincode,
    required this.clinicContact,
    required this.endTime,
    required this.days,
    required this.appointmentList,
    required this.prescriptionList,
    required this.appointmentDto,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'],
      location: json['location'],
      clinicName: json['clinicName'],
      incharge: json['incharge'],
      clinicNewFees: json['clinicNewFees'],
      clinicOldFees: json['clinicOldFees'],
      startTime: json['startTime'],
      pincode: json['pincode'],
      clinicContact: json['clinicContact'],
      endTime: json['endTime'],
      days: List<String>.from(json['days']),
      appointmentList: (json['appointmentList'] as List).map((i) => Appointment.fromJson(i)).toList(),
      prescriptionList: (json['prescriptionList'] as List).map((i) => Prescription.fromJson(i)).toList(),
      appointmentDto: (json['appointmentDto'] as List).map((i) => AppointmentDto.fromJson(i)).toList(),
    );
  }
}

class Doctor {
  final int id;
  final String firstName;
  final String lastName;
  final List<String> specialization;
  final List<String> degree;
  final int experience;
  final List<String> researchJournal;
  final List<String> citations;
  final List<String> achievements;
  final String licenceNumber;
  final String contact;
  final String email;
  final String password;
  final DoctorIntr docIntr;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.specialization,
    required this.degree,
    required this.experience,
    required this.researchJournal,
    required this.citations,
    required this.achievements,
    required this.licenceNumber,
    required this.contact,
    required this.email,
    required this.password,
    required this.docIntr,
  });

  factory Doctor.formJson(Map<String, dynamic> json){
    return Doctor(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      specialization: json['specialization'],
      degree: json['degree'],
      experience: json['experience'],
      researchJournal: List<String>.from(json['researchJournal']),
      citations: List<String>.from(json['citations']),
      achievements: List<String>.from(json['achievements']),
      licenceNumber: json['licenceNumber'],
      contact: json['contact'],
      email: json['email'],
      password: json['password'],
      docIntr: DoctorIntr.fromJson(json['docIntr']),
    );
  }

}

class AppointmentDto{
  final int id;
  final String name;
  final String contact;
  final String abhaNumber;
  final String aadharNumber;
  final String paymentStatus;
  final String appointmentvisitStatus;
  final int age;
  final String gender;
  final String appointmentDate;
  final String appointmentTime;
  final String clinicLocation;
  final Clinic clinic;

  AppointmentDto({
    required this.id,
    required this.name,
    required this.contact,
    required this.abhaNumber,
    required this.aadharNumber,
    required this.paymentStatus,
    required this.appointmentvisitStatus,
    required this.age,
    required this.gender,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.clinicLocation,
    required this.clinic,
});

  factory AppointmentDto.fromJson(Map<String, dynamic> json){
    return AppointmentDto(
      id: json['id'],
      name: json['name'],
      contact: json['contact'],
      abhaNumber: json['abhaNumber'],
      aadharNumber: json['aadharNumber'],
      paymentStatus: json['paymentStatus'],
      appointmentvisitStatus: json['appointmentvisitStatus'],
      age: json['age'],
      gender: json['gender'],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      clinicLocation: json['clinicLocation'],
      clinic: Clinic.fromJson(json['clinic']),
    );
  }

}

class Appointment{
  final int id;
  final String name;
  final String contact;
  final String paymentStatus;
  final String appointmentvisitStatus;
  final String abhaNumber;
  final String age;
  final String gender;
  final String appointmentDate;
  final String appointmentTime;
  final String clinicLocation;
  final Doctor doctor;
  final List<Prescription> prescriptionList;
  final AppointmentDto appointmentDto;

  Appointment({
    required this.id,
    required this.name,
    required this.contact,
    required this.paymentStatus,
    required this.appointmentvisitStatus,
    required this.abhaNumber,
    required this.age,
    required this.gender,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.clinicLocation,
    required this.doctor,
    required this.prescriptionList,
    required this.appointmentDto,
});

  factory Appointment.fromJson(Map<String, dynamic> json){
    return Appointment(
      id: json['id'],
      name: json['name'],
      contact: json['contact'],
      paymentStatus: json['paymentStatus'],
      appointmentvisitStatus: json['appointmentvisitStatus'],
      abhaNumber: json['abhaNumber'],
      age: json['age'],
      gender: json['gender'],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      clinicLocation: json['clinicLocation'],
      doctor: json['doctor'],
      prescriptionList: (json['prescriptionList'] as List).map((i) => Prescription.fromJson(i)).toList(),
      appointmentDto: AppointmentDto.fromJson(json['appointmentDto']),
    );
  }

}

class Prescription {
  Prescription();

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription();
  }
}

