import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fse_assistant/features/auth/domain/usecases/login.dart';
import 'package:fse_assistant/features/auth/presentation/controllers/repository_provider.dart';

import '../../domain/usecases/confirm_password_reset_code.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/initialise.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/send_password_reset_email.dart';
import '../../domain/usecases/signup.dart';

//initiaalise app provider
final initialiseUseCaseProvider = Provider<InitialiseUseCase>((ref) {
  return InitialiseUseCaseImpl(ref.read(userRepositoryProvider));
});

//getUSer provider
final getUserUseCaseProvider = Provider<GetUserUSeCase>((ref) {
  return GetUserUSeCaseImpl(ref.read(userRepositoryProvider));
});

//login provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCaseImpl(ref.read(userRepositoryProvider));
});

//signup provider
final signupUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCaseImpl(ref.read(userRepositoryProvider));
});

//logout provider
final logoutUSeCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCaseImpl(ref.read(userRepositoryProvider));
});

//send password reset email provider
final sendPasswordResetEmailUSeCaseProvider =
    Provider<SendPasswordResetEmailUseCase>((ref) {
  return SendPasswordResetEmailUseCaseImpl(ref.read(userRepositoryProvider));
});

//confirm password reset code provider
final confirmPasswordResetCodeUSeCaseProvider =
    Provider<ConfirmPasswordResetCodeUSeCase>((ref) {
  return ConfirmPasswordResetCodeUseCaseImpl(ref.read(userRepositoryProvider));
});
