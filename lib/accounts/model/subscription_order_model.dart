class SubscriptionOrderModel {
  int? amount;
  int? amountPaid;
  List<dynamic>? notes;
  int? createdAt;
  int? amountDue;
  String? currency;
  String? receipt;
  String? id;
  String? entity;
  int? attempts;
  String? status;

  SubscriptionOrderModel({
    this.amount,
    this.amountPaid,
    this.notes,
    this.createdAt,
    this.amountDue,
    this.currency,
    this.receipt,
    this.id,
    this.entity,
    this.attempts,
    this.status,
  });

  SubscriptionOrderModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    notes = json['notes'];
    createdAt = json['created_at'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    id = json['id'];
    entity = json['entity'];
    attempts = json['attempts'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['amount_paid'] = this.amountPaid;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    data['amount_due'] = this.amountDue;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    data['id'] = this.id;
    data['entity'] = this.entity;
    data['attempts'] = this.attempts;
    data['status'] = this.status;
    return data;
  }
}
