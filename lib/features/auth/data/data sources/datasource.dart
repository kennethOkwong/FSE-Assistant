import 'package:dartz/dartz.dart';
import 'package:fse_assistant/features/auth/data/models/user_model.dart';

import '../../../../core/resources/failure.dart';

abstract class DataSource {
  Future<Either<Failure, void>> initialise();

  Either<Failure, UserDTO> getUSer();

  Future<Either<Failure, UserDTO>> login(String email, String password);

  Future<Either<Failure, UserDTO>> signup(String email, String password);

  Future<void> logout();

  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  Future<Either<Failure, void>> confirmPasswordResetCode(
      String code, String email);
}
