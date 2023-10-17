class Refunds {
  String insuranceDocument;
  String ibanBankAccount;
  String vehicleRegistrationCard;
  String idCard;
  String userId;
  String status;
  String phoneNumber;
  String requestId;
  String requestType;
  String requestDate;
  String companyName;

  Refunds({
    required this.idCard,
    required this.ibanBankAccount,
    required this.vehicleRegistrationCard,
    required this.insuranceDocument,
    required this.userId,
    required this.status,
    required this.phoneNumber,
    required this.requestId,
    required this.requestType,
    required this.requestDate,
    required this.companyName,
  });

  factory Refunds.fromMap(Map<String, dynamic> map) {
    return Refunds(
      idCard: map['idCard'] ?? '0',
      ibanBankAccount: map['ibanBankAccount'] ?? '',
      vehicleRegistrationCard: map['vehicleRegistrationCard'] ?? '',
      insuranceDocument: map['insuranceDocument'] ?? '',
      userId: map['userId'] ?? '',
      status: map['status'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      requestId: map['requestId'] ?? '',
      requestType: map['requestType'] ?? '',
      requestDate: map['requestDate'] ?? '',
      companyName: map['companyName'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idCard': idCard,
      'ibanBankAccount': ibanBankAccount,
      'vehicleRegistrationCard': vehicleRegistrationCard,
      'insuranceDocument': insuranceDocument,
      'userId': userId,
      'status': status,
      'phoneNumber': phoneNumber,
      'requestId': requestId,
      'requestType': requestType,
      'requestDate': requestDate,
      'companyName': companyName,
    };
  }
}
