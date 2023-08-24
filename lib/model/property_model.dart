class PropertyModel {
  String propertyName;
  String client;
  String propertyAddress;
  String propertyId;
  String propertyType;
  String city;
  String state;
  String propertyArea;
  // String propertyUrl;
  String pinCode;
  String uid;
  String registeredOn;
  String status;

  PropertyModel({
    required this.propertyName,
    required this.propertyType,
    required this.client,
    required this.propertyAddress,
    required this.propertyId,
    required this.city,
    required this.state,
    required this.propertyArea,
    // required this.propertyUrl,
    required this.pinCode,
    required this.uid,
    required this.registeredOn,
    required this.status,
  });

  // from map
  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      propertyName: map['propertyName'] ?? '',
      propertyType: map['propertyType'] ?? '',
      client: map['client'] ?? '',
      propertyAddress: map['propertyAddress'] ?? '',
      propertyId: map['propertyId'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      propertyArea: map['propertyArea'] ?? '',
      // propertyUrl: map['propertyUrl'] ?? '',
      pinCode: map['pinCode'] ?? '',
      uid: map['uid'] ?? '',
      registeredOn: map['registeredOn'] ?? '',
      status: map['status'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "propertyName": propertyName,
      "propertyType": propertyType,
      "client": client,
      "propertyAddress": propertyAddress,
      "propertyId": propertyId,
      "city": city,
      "state": state,
      "propertyArea": propertyArea,
      // "propertyUrl": propertyUrl,
      "pinCode": pinCode,
      "uid": uid,
      "registeredOn": registeredOn,
      "status": status,
    };
  }
}
