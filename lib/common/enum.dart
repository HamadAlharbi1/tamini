enum QuotationStatus {
  newRequest,
  pending,
  approved,
  rejected,
}

enum UserType { user, owner }

enum RequestType { quotation, refund }

enum RefundStatus { newRequest, inProgress, pending, approved, rejected, docsNotAccepted }
