import 'package:dartz/dartz.dart';
import 'package:fse_assistant/features/auth/domain/repository/user.dart';

import '../../../../core/resources/failure.dart';

abstract class InitialiseUseCase {
  Future<Either<Failure, void>> execute();
}

class InitialiseUseCaseImpl implements InitialiseUseCase {
  final UserRepository userRepository;

  InitialiseUseCaseImpl(this.userRepository);

  @override
  Future<Either<Failure, void>> execute() async {
    return await userRepository.initialise();
  }
}
