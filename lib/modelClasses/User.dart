class User {
  final String emailID;
  final String profilePictureURL;
  final String displayName;
  final String phoneNumber;

  User(
      {this.emailID,
      this.profilePictureURL,
      this.displayName,
      this.phoneNumber});

  User.fromJSON(Map<String, String> json)
      : displayName = json['displayName'],
        emailID = json['emailID'],
        profilePictureURL = json['profilePictureURL'],
        phoneNumber = json['phoneNumber'];

  Map<String, dynamic> toJSON() => {
        'displayName': displayName,
        'emailID': emailID,
        'profilePictureURL': profilePictureURL,
        'phoneNumber': phoneNumber,
      };
}
