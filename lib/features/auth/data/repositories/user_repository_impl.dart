import 'package:dartz/dartz.dart';
import 'package:fse_assistant/core/models/failure.dart';
import 'package:fse_assistant/features/auth/data/data%20sources/datasource.dart';
import 'package:fse_assistant/features/auth/data/models/user_model.dart';

import 'package:fse_assistant/features/auth/domain/repository/user.dart';

class UserRepositoryImpl implements UserRepository {
  final DataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> initialise() async {
    return await dataSource.initialise();
  }

  @override
  Either<Failure, UserDTO> getUser() {
    return dataSource.getUSer();
  }

  @override
  Future<Either<Failure, UserDTO>> login(String email, String password) async {
    return await dataSource.login(email, password);
  }

  @override
  Future<Either<Failure, UserDTO>> signup(String email, String password) async {
    return await dataSource.signup(email, password);
  }

  @override
  Future<void> logout() async {
    return await dataSource.logout();
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    return await dataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<Either<Failure, void>> confirmPasswordResetCode(
      String code, String password) async {
    return await dataSource.confirmPasswordResetCode(code, password);
  }
}
