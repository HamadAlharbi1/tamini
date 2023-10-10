class UserData {
  String userId;
  String userName;
  String email;
  String phoneNumber;
  String profilePictureUrl;
  String userType;
  UserData(
      {required this.userId,
      required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.profilePictureUrl,
      required this.userType});
  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      userId: map['userId'],
      userName: map['userName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      profilePictureUrl: map['profilePictureUrl'],
      userType: map['userType'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePictureUrl': profilePictureUrl,
      'userType': userType
    };
  }
}
