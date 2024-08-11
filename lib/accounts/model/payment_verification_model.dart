class RazorpayPaymentVerificationModel {
  int? amount;
  String? method;
  String? vpa;
  int? fee;
  String? description;
  int? createdAt;
  int? tax;
  int? amountRefunded;
  Upi? upi;
  AcquirerData? acquirerData;
  bool? captured;
  String? contact;
  String? currency;
  String? id;
  bool? international;
  String? orderId;
  String? email;
  String? entity;
  String? status;

  RazorpayPaymentVerificationModel(
      {this.amount,
        this.method,
        this.vpa,
        this.fee,
        this.description,
        this.createdAt,
        this.tax,
        this.amountRefunded,
        this.upi,
        this.acquirerData,
        this.captured,
        this.contact,
        this.currency,
        this.id,
        this.international,
        this.orderId,
        this.email,
        this.entity,
        this.status});

  RazorpayPaymentVerificationModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
        method = json['method'];
    vpa = json['vpa'];
    fee = json['fee'];
    description = json['description'];
    createdAt = json['created_at'];
    tax = json['tax'];
    amountRefunded = json['amount_refunded'];
    upi = json['upi'] != null ? new Upi.fromJson(json['upi']) : null;
    acquirerData = json['acquirer_data'] != null
        ? new AcquirerData.fromJson(json['acquirer_data'])
        : null;
    captured = json['captured'];
    contact = json['contact'];
    currency = json['currency'];
    id = json['id'];
    international = json['international'];
    orderId = json['order_id'];
    email = json['email'];
    entity = json['entity'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['method'] = this.method;
    data['vpa'] = this.vpa;
    data['fee'] = this.fee;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['tax'] = this.tax;
    data['amount_refunded'] = this.amountRefunded;
    if (this.upi != null) {
      data['upi'] = this.upi!.toJson();
    }
    if (this.acquirerData != null) {
      data['acquirer_data'] = this.acquirerData!.toJson();
    }
    data['captured'] = this.captured;
    data['contact'] = this.contact;
    data['currency'] = this.currency;
    data['id'] = this.id;
    data['international'] = this.international;
    data['order_id'] = this.orderId;
    data['email'] = this.email;
    data['entity'] = this.entity;
    data['status'] = this.status;
    return data;
  }
}

class Upi {
  String? payerAccountType;
  String? vpa;

  Upi({this.payerAccountType, this.vpa});

  Upi.fromJson(Map<String, dynamic> json) {
    payerAccountType = json['payer_account_type'];
    vpa = json['vpa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payer_account_type'] = this.payerAccountType;
    data['vpa'] = this.vpa;
    return data;
  }
}

class AcquirerData {
  String? upiTransactionId;
  String? rrn;

  AcquirerData({this.upiTransactionId, this.rrn});

  AcquirerData.fromJson(Map<String, dynamic> json) {
    upiTransactionId = json['upi_transaction_id'];
    rrn = json['rrn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['upi_transaction_id'] = this.upiTransactionId;
    data['rrn'] = this.rrn;
    return data;
  }
}
