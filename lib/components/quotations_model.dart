class Quotations {
  String nationalId;
  String birthDate;
  String carSerialNumber;
  String userId;
  String status;
  String phoneNumber;
  double insuranceAmount;
  String requestId;
  String requestType;
  String requestDate;

  Quotations({
    required this.nationalId,
    required this.birthDate,
    required this.carSerialNumber,
    required this.userId,
    required this.status,
    required this.phoneNumber,
    required this.insuranceAmount,
    required this.requestId,
    required this.requestType,
    required this.requestDate,
  });

  factory Quotations.fromMap(Map<String, dynamic> map) {
    return Quotations(
      nationalId: map['nationalId'] ?? '0',
      birthDate: map['birthDate'] ?? '',
      carSerialNumber: map['carSerialNumber'] ?? '',
      userId: map['userId'] ?? '',
      status: map['status'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      insuranceAmount: map['insuranceAmount'] ?? 0.0,
      requestId: map['requestId'] ?? '',
      requestType: map['requestType'] ?? '',
      requestDate: map['requestDate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nationalId': nationalId,
      'birthDate': birthDate,
      'carSerialNumber': carSerialNumber,
      'userId': userId,
      'status': status,
      'phoneNumber': phoneNumber,
      'insuranceAmount': insuranceAmount,
      'requestId': requestId,
      'requestType': requestType,
      'requestDate': requestDate,
    };
  }
}
