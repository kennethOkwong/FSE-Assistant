import 'package:dartz/dartz.dart';
import 'package:fse_assistant/core/resources/failure.dart';
import 'package:fse_assistant/features/auth/domain/entity/user.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> initialise();

  Either<Failure, User> getUser();

  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, User>> signup(String email, String password);

  Future<void> logout();

  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  Future<Either<Failure, void>> confirmPasswordResetCode(
    String code,
    String password,
  );
}
