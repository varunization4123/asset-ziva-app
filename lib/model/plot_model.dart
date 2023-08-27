class PlotModel {
  String plotName;
  String plotType;
  String plotAddress;
  String client;
  String plotId;
  String city;
  String state;
  String plotArea;
  // String plotUrl;
  String pinCode;
  String uid;
  String registeredOn;
  String status;

  PlotModel({
    required this.plotName,
    required this.plotType,
    required this.client,
    required this.plotAddress,
    required this.plotId,
    required this.city,
    required this.state,
    required this.plotArea,
    // required this.plotUrl,
    required this.pinCode,
    required this.uid,
    required this.registeredOn,
    required this.status,
  });

  // from map
  factory PlotModel.fromMap(Map<String, dynamic> map) {
    return PlotModel(
      plotName: map['plotName'] ?? '',
      plotType: map['plotType'] ?? '',
      client: map['client'] ?? '',
      plotAddress: map['plotAddress'] ?? '',
      plotId: map['plotId'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      plotArea: map['plotArea'] ?? '',
      // plotUrl: map['plotUrl'] ?? '',
      pinCode: map['pinCode'] ?? '',
      uid: map['uid'] ?? '',
      registeredOn: map['registeredOn'] ?? '',
      status: map['status'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "plotName": plotName,
      "plotType": plotType,
      "client": client,
      "plotAddress": plotAddress,
      "plotId": plotId,
      "city": city,
      "state": state,
      "plotArea": plotArea,
      // "plotUrl": plotUrl,
      "pinCode": pinCode,
      "uid": uid,
      "registeredOn": registeredOn,
      "status": status,
    };
  }
}
