import 'package:tamini_app/common/enum.dart';

class Quotations {
  String newOwnerNationalId;
  String newOwnerBirthDate;
  String carSerialNumber;
  String userId;
  String status;
  String phoneNumber;
  double insuranceAmount;
  String requestId;
  String requestType;
  String requestDate;
  String sellerNationalId; // Existing field
  String sellerBirthDate; // Existing field
  String quotationType; // New field

  Quotations({
    required this.newOwnerNationalId,
    required this.newOwnerBirthDate,
    required this.carSerialNumber,
    required this.userId,
    required this.status,
    required this.phoneNumber,
    required this.insuranceAmount,
    required this.requestId,
    required this.requestType,
    required this.requestDate,
    required this.sellerNationalId, // Existing parameter
    required this.sellerBirthDate, // Existing parameter
    required this.quotationType, // New parameter
  });

  factory Quotations.fromMap(Map<String, dynamic> map) {
    return Quotations(
      newOwnerNationalId: map['newOwnerNationalId'] ?? '0',
      newOwnerBirthDate: map['newOwnerBirthDate'] ?? '',
      carSerialNumber: map['carSerialNumber'] ?? '',
      userId: map['userId'] ?? '',
      status: map['status'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      insuranceAmount: map['insuranceAmount']?.toDouble() ?? 0.0,
      requestId: map['requestId'] ?? '',
      requestType: map['requestType'] ?? '',
      requestDate: map['requestDate'] ?? '',
      sellerNationalId: map['sellerNationalId'] ?? '', // Existing map retrieval
      sellerBirthDate: map['sellerBirthDate'] ?? '', // Existing map retrieval
      quotationType: map['quotationType'] ?? QuotationType.newCarQuotation.name, // New map retrieval
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'newOwnerNationalId': newOwnerNationalId,
      'newOwnerBirthDate': newOwnerBirthDate,
      'carSerialNumber': carSerialNumber,
      'userId': userId,
      'status': status,
      'phoneNumber': phoneNumber,
      'insuranceAmount': insuranceAmount,
      'requestId': requestId,
      'requestType': requestType,
      'requestDate': requestDate,
      'sellerNationalId': sellerNationalId, // Existing map entry
      'sellerBirthDate': sellerBirthDate, // Existing map entry
      'quotationType': quotationType, // New map entry
    };
  }
}
