import 'package:dartz/dartz.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/failure.dart';
import '../../domain/entity/user.dart';
import 'usecases_providers.dart';

class AuthStateNotifier
    extends StateNotifier<AsyncValue<Either<Failure, User>>> {
  AuthStateNotifier(this.ref) : super(const AsyncValue.loading()) {
    getUSer();
  }

  final Ref ref;

  Future<Either<Failure, void>> initialise() async {
    return await ref.read(initialiseUseCaseProvider).execute();
  }

  void getUSer() async {
    final user = await ref.read(getUserUseCaseProvider).execute();
    state = AsyncValue.data(user);
  }

  Future<Either<Failure, User>?> login(String email, String password) async {
    return await ref.read(loginUseCaseProvider).execute(email, password);
  }

  Future<Either<Failure, User>?> signup(String email, String password) async {
    return await ref.read(signupUseCaseProvider).execute(email, password);
  }

  Future<void> logout() async {
    return await ref.read(logoutUSeCaseProvider).execute();
  }
}

final authStateNotifierProvider = StateNotifierProvider<AuthStateNotifier,
    AsyncValue<Either<Failure, User>?>>((ref) {
  return AuthStateNotifier(ref);
});

//Signin or signup provider
class AuthProviderNotifier extends StateNotifier<bool> {
  AuthProviderNotifier() : super(true);

  bool toggleAuthPage() {
    return state = !state;
  }
}

final authProvider = StateNotifierProvider<AuthProviderNotifier, bool>((ref) {
  return AuthProviderNotifier();
});

final model = Provider((ref) => AuthProviderNotifier());
