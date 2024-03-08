import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String userId = '';
  String email = '';

  UserModel({
    required this.userId,
    required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    email = json['id'];
  }

  UserModel.fromFirebase(User firebaseUser) {
    userId = firebaseUser.uid;
    email = firebaseUser.email ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
    };
  }
}
