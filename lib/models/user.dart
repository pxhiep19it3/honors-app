class Users {
  String? id;
  String? displayName;
  String? email;
  String? photoURL;
  Users({
    this.id,
    this.displayName,
    this.email,
    this.photoURL,
  });
  Map<String, String> toJson() {
    return {
      'id': id!,
      'displayName': displayName!,
      'email': email!,
      'photoURL': photoURL!,
    };
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        id: json['id'].toString(),
        displayName: json['displayName'].toString(),
        email: json['email'].toString(),
        photoURL: json['photoURL'].toString());
  }
}
