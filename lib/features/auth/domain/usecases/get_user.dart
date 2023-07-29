import 'package:dartz/dartz.dart';
import 'package:fse_assistant/core/resources/failure.dart';
import 'package:fse_assistant/features/auth/domain/entity/user.dart';

import '../repository/user.dart';

abstract class GetUserUSeCase {
  Future<Either<Failure, User>> execute();
}

class GetUserUSeCaseImpl implements GetUserUSeCase {
  final UserRepository userRepository;

  GetUserUSeCaseImpl(this.userRepository);

  @override
  Future<Either<Failure, User>> execute() async {
    return userRepository.getUser();
  }
}
