class PropertyServicesModel {
  String service;
  String client;
  String amount;
  String city;
  String document;
  String propertyId;
  String uid;
  String paymentId;

  PropertyServicesModel({
    required this.service,
    required this.client,
    required this.amount,
    required this.city,
    required this.document,
    required this.propertyId,
    required this.uid,
    required this.paymentId,
  });

  // from map
  factory PropertyServicesModel.fromMap(Map<String, dynamic> map) {
    return PropertyServicesModel(
      service: map['service'] ?? '',
      client: map['client'] ?? '',
      amount: map['amount'] ?? '',
      city: map['city'] ?? '',
      document: map['document'] ?? '',
      propertyId: map['propertyId'] ?? '',
      uid: map['uid'] ?? '',
      paymentId: map['paymentId'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "service": service,
      "client": client,
      "amount": amount,
      "city": city,
      "document": document,
      "propertyId": propertyId,
      "uid": uid,
      "paymentId": paymentId,
    };
  }
}
