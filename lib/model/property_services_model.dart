class ServicesModel {
  String service;
  String amount;
  String city;
  String document;
  String propertyId;
  String uid;

  ServicesModel({
    required this.service,
    required this.amount,
    required this.city,
    required this.document,
    required this.propertyId,
    required this.uid,
  });

  // from map
  factory ServicesModel.fromMap(Map<String, dynamic> map) {
    return ServicesModel(
      service: map['service'] ?? '',
      amount: map['amount'] ?? '',
      city: map['city'] ?? '',
      document: map['document'] ?? '',
      propertyId: map['propertyId'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "service": service,
      "amount": amount,
      "city": city,
      "document": document,
      "propertyId": propertyId,
      "uid": uid,
    };
  }
}
