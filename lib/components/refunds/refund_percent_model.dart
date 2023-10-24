class RefundPercent {
  final String days;
  final String refundPercent;

  RefundPercent({required this.days, required this.refundPercent});
}

List<RefundPercent> refundPercentList = [
  RefundPercent(days: "1-7", refundPercent: "87.5"),
  RefundPercent(days: "8-30", refundPercent: "75"),
  RefundPercent(days: "31-60", refundPercent: "60"),
  RefundPercent(days: "61-90", refundPercent: "50"),
  RefundPercent(days: "91-120", refundPercent: "45"),
  RefundPercent(days: "121-150", refundPercent: "40"),
  RefundPercent(days: "151-180", refundPercent: "35"),
  RefundPercent(days: "181-210", refundPercent: "25"),
  RefundPercent(days: "211-240", refundPercent: "20"),
  RefundPercent(days: "270-241", refundPercent: "10"),
  RefundPercent(days: "271-365", refundPercent: "0"),
];
