/*
{
"data": {
"id": 116,
"modeOfPayment": "upi",
"amount": 100.0,
"createdAt": null,
"updatedAt": null,
"appointment": null
},
"statusCode": 200,
"message": "Appointment Payment Status data"
}*/

class PaymentInfoModel {
  Data? data;
  int? statusCode;
  String? message;

  PaymentInfoModel({this.data, this.statusCode, this.message});

  PaymentInfoModel.fromJson(Map<String, dynamic> json) {
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
  String? modeOfPayment;
  int? amount;
  Null createdAt;
  Null updatedAt;
  Null appointment;

  Data(
      {this.id,
        this.modeOfPayment,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.appointment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modeOfPayment = json['modeOfPayment'];
    amount = json['amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    appointment = json['appointment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modeOfPayment'] = this.modeOfPayment;
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['appointment'] = this.appointment;
    return data;
  }
}
