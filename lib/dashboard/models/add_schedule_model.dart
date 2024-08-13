class ScheduleModel {
  ScheduleData? scheduleData;
  int? statusCode;
  String? message;

  ScheduleModel({this.scheduleData, this.statusCode, this.message});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    scheduleData = json['scheduleData'] != null
        ? new ScheduleData.fromJson(json['scheduleData'])
        : null;
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.scheduleData != null) {
      data['scheduleData'] = this.scheduleData!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class ScheduleData {
  int? id;
  String? startTime;
  String? endTime;
  String? clinicName;
  String? stDate;
  String? endDate;
  String? purpose;
  int? doctorId;

  ScheduleData(
      {this.id,
        this.startTime,
        this.endTime,
        this.clinicName,
        this.stDate,
        this.endDate,
        this.purpose,
        this.doctorId,
        });

  ScheduleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    clinicName = json['clinicName'];
    stDate = json['stDate'];
    endDate = json['endDate'];
    purpose = json['purpose'];
    doctorId = json['doctorId'];

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
    return data;
  }
}
