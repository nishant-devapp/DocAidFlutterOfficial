class AmountModel {
  Data? data;
  int? statusCode;
  String? message;

  AmountModel({this.data, this.statusCode, this.message});

  AmountModel.fromJson(Map<String, dynamic> json) {
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
  double? totalAmount;
  double? cashAmount;
  double? upiAmount;

  Data({this.totalAmount, this.cashAmount, this.upiAmount});

  Data.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    cashAmount = json['cashAmount'];
    upiAmount = json['upiAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAmount'] = this.totalAmount;
    data['cashAmount'] = this.cashAmount;
    data['upiAmount'] = this.upiAmount;
    return data;
  }
}
