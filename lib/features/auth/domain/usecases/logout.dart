import 'package:fse_assistant/features/auth/domain/repository/user.dart';

abstract class LogoutUseCase {
  Future<void> execute();
}

class LogoutUseCaseImpl extends LogoutUseCase {
  final UserRepository userRepository;

  LogoutUseCaseImpl(this.userRepository);

  @override
  Future<void> execute() async {
    return await userRepository.logout();
  }
}
