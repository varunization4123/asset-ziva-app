class PlotModel {
  String plotName;
  String plotAddress;
  String plotId;
  String city;
  String state;
  String plotArea;
  // String plotUrl;
  String pinCode;
  String uid;
  final services;

  PlotModel({
    required this.plotName,
    required this.plotAddress,
    required this.plotId,
    required this.city,
    required this.state,
    required this.plotArea,
    // required this.plotUrl,
    required this.pinCode,
    required this.uid,
    required this.services,
  });

  // from map
  factory PlotModel.fromMap(Map<String, dynamic> map) {
    return PlotModel(
      plotName: map['plotName'] ?? '',
      plotAddress: map['plotAddress'] ?? '',
      plotId: map['plotId'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      plotArea: map['plotArea'] ?? '',
      // plotUrl: map['plotUrl'] ?? '',
      pinCode: map['pinCode'] ?? '',
      uid: map['uid'] ?? '',
      services: map['services'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "plotName": plotName,
      "plotAddress": plotAddress,
      "plotId": plotId,
      "city": city,
      "state": state,
      "plotArea": plotArea,
      // "plotUrl": plotUrl,
      "pinCode": pinCode,
      "uid": uid,
      "services": services,
    };
  }
}
