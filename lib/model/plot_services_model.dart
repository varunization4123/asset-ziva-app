class PlotServicesModel {
  String service;
  String amount;
  String city;
  String document;
  String plotId;
  String uid;
  String paymentId;

  PlotServicesModel({
    required this.service,
    required this.amount,
    required this.city,
    required this.document,
    required this.plotId,
    required this.uid,
    required this.paymentId,
  });

  // from map
  factory PlotServicesModel.fromMap(Map<String, dynamic> map) {
    return PlotServicesModel(
      service: map['service'] ?? '',
      amount: map['amount'] ?? '',
      city: map['city'] ?? '',
      document: map['document'] ?? '',
      plotId: map['plotId'] ?? '',
      uid: map['uid'] ?? '',
      paymentId: map['paymentId'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "service": service,
      "amount": amount,
      "city": city,
      "document": document,
      "propertyId": plotId,
      "uid": uid,
      "paymentId": paymentId,
    };
  }
}
