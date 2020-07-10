class User {
  final String id;
  final String fullName;
  final String email;
  final String photoUrl;
  final String bio;
  User({this.id, this.fullName, this.email, this.photoUrl, this.bio});
  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        photoUrl = data['photoUrl'],
        bio = data['bio'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio
    };
  }
}
