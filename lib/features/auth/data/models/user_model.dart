import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../domain/entity/user.dart';

class UserDTO extends User {
  const UserDTO({
    required String id,
    required String email,
  }) : super(id: id, email: email);

  factory UserDTO.fromFirebase(auth.User user) {
    return UserDTO(id: user.uid, email: user.email!);
  }

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'] as String,
      email: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson(UserDTO user) {
    return {
      'id': user.id,
      'email': user.email,
    };
  }
}
