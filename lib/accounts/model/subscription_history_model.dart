class SubscriptionHistoryModel {
  List<SubscriptionData>? data;
  int? statusCode;
  String? message;

  SubscriptionHistoryModel({this.data, this.statusCode, this.message});

  SubscriptionHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SubscriptionData>[];
      json['data'].forEach((v) {
        data!.add(new SubscriptionData.fromJson(v));
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

class SubscriptionData {
  int? id;
  String? paymentId;
  String? orderId;
  int? amount;
  String? invoiceId;
  String? paymentDate;
  int? duration;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  int? doctorId;

  SubscriptionData(
      {this.id,
        this.paymentId,
        this.orderId,
        this.amount,
        this.invoiceId,
        this.paymentDate,
        this.duration,
        this.subscriptionStartDate,
        this.subscriptionEndDate,
        this.doctorId});

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['paymentId'];
    orderId = json['orderId'];
    amount = json['amount'];
    invoiceId = json['invoiceId'];
    paymentDate = json['paymentDate'];
    duration = json['duration'];
    subscriptionStartDate = json['subscriptionStartDate'];
    subscriptionEndDate = json['subscriptionEndDate'];
    doctorId = json['doctorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paymentId'] = this.paymentId;
    data['orderId'] = this.orderId;
    data['amount'] = this.amount;
    data['invoiceId'] = this.invoiceId;
    data['paymentDate'] = this.paymentDate;
    data['duration'] = this.duration;
    data['subscriptionStartDate'] = this.subscriptionStartDate;
    data['subscriptionEndDate'] = this.subscriptionEndDate;
    data['doctorId'] = this.doctorId;
    return data;
  }
}
