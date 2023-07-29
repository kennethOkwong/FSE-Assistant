import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../../../core/resources/failure.dart';
import '../datasource.dart';
import '/features/auth/data/models/user_model.dart';

final firebase = FirebaseAuth.instance;

class FirebaseDataSource implements DataSource {
  @override
  Future<Either<Failure, void>> initialise() async {
    try {
      await Firebase.initializeApp();
      return const Right(null);
    } catch (error) {
      return const Left(Failure(message: 'App Initialization Error'));
    }
  }

  // @override
  // Either<Failure, UserDTO> getUSer() {
  //   try {
  //     final user = firebase.currentUser;
  //     return Right(UserDTO(id: user!.uid, email: user.email!));
  //   } catch (error) {
  //     return const Left(Failure(message: "Unable to get User"));
  //   }
  // }

  @override
  Either<Failure, UserDTO> getUSer() {
    try {
      Firebase.initializeApp();

      final user = firebase.currentUser;

      if (user == null || user.email == null) {
        return const Left(Failure(message: "Unable to get User"));
      }

      return Right(UserDTO(id: user.uid, email: user.email!));
    } catch (error) {
      return const Left(Failure(message: 'Unable to get user'));
    }
  }

  @override
  Future<Either<Failure, UserDTO>> login(String email, String password) async {
    try {
      final userCredetials = await firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredetials.user == null) {
        return const Left(Failure(message: 'User not found'));
      }
      final user = UserDTO.fromFirebase(userCredetials.user!);
      log(user.email);
      return Right(user);
    } on FirebaseAuthException catch (error) {
      return Left(Failure(
        errorCode: error.code,
        message: error.message ?? 'Authentication Error',
      ));
    } catch (error) {
      return const Left(Failure(
        message: 'Unknown Authentication Error',
      ));
    }
  }

  @override
  Future<Either<Failure, UserDTO>> signup(String email, String password) async {
    try {
      final userCredetials = await firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredetials.user == null) {
        return const Left(Failure(message: 'User not found'));
      }

      return Right(UserDTO.fromFirebase(userCredetials.user!));
    } on FirebaseAuthException catch (error) {
      log(error.toString());
      return Left(Failure(
        errorCode: error.code,
        message: error.message ?? 'Authentication Error',
      ));
    } catch (error) {
      log(error.toString());
      return const Left(Failure(
        message: 'Unknown Authentication Error',
      ));
    }
  }

  @override
  Future<void> logout() async {
    return await firebase.signOut();
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await firebase.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(Failure(
        errorCode: error.code,
        message: error.message ?? 'Authentication Error',
      ));
    } catch (_) {
      return const Left(Failure(
        message: 'Unknown Authentication Error',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPasswordResetCode(
    String code,
    String newPassword,
  ) async {
    try {
      await firebase.confirmPasswordReset(code: code, newPassword: newPassword);
      return const Right(null);
    } on FirebaseAuthException catch (error) {
      return Left(Failure(
        errorCode: error.code,
        message: error.message ?? 'Authentication Error',
      ));
    } catch (_) {
      return const Left(Failure(
        message: 'Unknown Authentication Error',
      ));
    }
  }
}
