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
  String sellerNationalId;
  String sellerBirthDate;
  String quotationType;
  String startInsuranceDate;

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
    required this.sellerNationalId,
    required this.sellerBirthDate,
    required this.quotationType,
    required this.startInsuranceDate,
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
      sellerNationalId: map['sellerNationalId'] ?? '',
      sellerBirthDate: map['sellerBirthDate'] ?? '',
      quotationType: map['quotationType'] ?? QuotationType.newCarQuotation.name,
      startInsuranceDate: map['startInsuranceDate'] ?? '',
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
      'sellerNationalId': sellerNationalId,
      'sellerBirthDate': sellerBirthDate,
      'quotationType': quotationType,
      'startInsuranceDate': startInsuranceDate,
    };
  }
}
