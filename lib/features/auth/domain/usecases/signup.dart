import 'package:dartz/dartz.dart';
import 'package:fse_assistant/features/auth/domain/repository/user.dart';

import '../../../../core/models/failure.dart';
import '../entity/user.dart';

abstract class SignUpUseCase {
  Future<Either<Failure, User>> execute(String email, String password);
}

class SignUpUseCaseImpl extends SignUpUseCase {
  final UserRepository userRepository;

  SignUpUseCaseImpl(this.userRepository);

  @override
  Future<Either<Failure, User>> execute(String email, String password) async {
    return await userRepository.signup(email, password);
  }
}
