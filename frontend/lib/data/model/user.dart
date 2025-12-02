class PsychUser {
  PsychUser({
    required this.uid,
    required this.email,
    required this.token,
    required this.displayName,
    this.phoneNumber,
    this.photoUrl,
  });

  factory PsychUser.fromJson(Map<String, dynamic> json) => PsychUser(
    uid: json['uid'],
    email: json['email'],
    displayName: json['display_name'],
    phoneNumber: json['phone_number'],
    photoUrl: json['photo_url'],
    token: json['id_token'],
  );
  String uid;
  String email;
  String displayName;
  String? phoneNumber;
  String? photoUrl;
  String token;

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'display_name': displayName,
    'phone_number': phoneNumber,
    'photo_url': photoUrl,
    'id_token': token,
  };
}
