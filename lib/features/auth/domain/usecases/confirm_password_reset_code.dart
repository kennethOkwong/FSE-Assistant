import 'package:dartz/dartz.dart';
import 'package:fse_assistant/features/auth/domain/repository/user.dart';

import '../../../../core/resources/failure.dart';

abstract class ConfirmPasswordResetCodeUSeCase {
  Future<Either<Failure, void>> execute(String code, String password);
}

class ConfirmPasswordResetCodeUseCaseImpl
    implements ConfirmPasswordResetCodeUSeCase {
  final UserRepository userRepository;

  ConfirmPasswordResetCodeUseCaseImpl(this.userRepository);

  @override
  Future<Either<Failure, void>> execute(String code, String password) async {
    return await userRepository.confirmPasswordResetCode(code, password);
  }
}
