class PropertyModel {
  String propertyName;
  String propertyAddress;
  String propertyId;
  String city;
  String state;
  String propertyArea;
  // String propertyUrl;
  String pinCode;
  String uid;

  PropertyModel({
    required this.propertyName,
    required this.propertyAddress,
    required this.propertyId,
    required this.city,
    required this.state,
    required this.propertyArea,
    // required this.propertyUrl,
    required this.pinCode,
    required this.uid,
  });

  // from map
  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      propertyName: map['propertyName'] ?? '',
      propertyAddress: map['propertyAddress'] ?? '',
      propertyId: map['propertyId'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      propertyArea: map['propertyArea'] ?? '',
      // propertyUrl: map['propertyUrl'] ?? '',
      pinCode: map['pinCode'] ?? '',
      uid: map['uid'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "propertyName": propertyName,
      "propertyAddress": propertyAddress,
      "propertyId": propertyId,
      "city": city,
      "state": state,
      "propertyArea": propertyArea,
      // "propertyUrl": propertyUrl,
      "pinCode": pinCode,
      "uid": uid,
    };
  }
}
