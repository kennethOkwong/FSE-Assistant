import 'package:dartz/dartz.dart';
import 'package:fse_assistant/features/auth/domain/repository/user.dart';

import '../../../../core/resources/failure.dart';

abstract class SendPasswordResetEmailUseCase {
  Future<Either<Failure, void>> execute(String email);
}

class SendPasswordResetEmailUseCaseImpl
    implements SendPasswordResetEmailUseCase {
  final UserRepository userRepository;

  SendPasswordResetEmailUseCaseImpl(this.userRepository);

  @override
  Future<Either<Failure, void>> execute(String email) async {
    return await userRepository.sendPasswordResetEmail(email);
  }
}
