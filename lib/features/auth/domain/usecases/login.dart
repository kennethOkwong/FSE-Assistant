import 'package:dartz/dartz.dart';

import '../../../../core/models/failure.dart';
import '../entity/user.dart';
import 'package:fse_assistant/features/auth/domain/repository/user.dart';

abstract class LoginUseCase {
  Future<Either<Failure, User>> execute(String email, String password);
}

class LoginUseCaseImpl implements LoginUseCase {
  final UserRepository userRepository;

  LoginUseCaseImpl(this.userRepository);

  @override
  Future<Either<Failure, User>> execute(String email, String password) async {
    return await userRepository.login(email, password);
  }
}
