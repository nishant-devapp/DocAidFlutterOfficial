class SubscriptionAmountModel {
  int? data;
  int? statusCode;
  String? message;

  SubscriptionAmountModel({this.data, this.statusCode, this.message});

  SubscriptionAmountModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}
