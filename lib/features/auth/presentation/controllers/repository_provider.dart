import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fse_assistant/features/auth/data/repositories/user_repository_impl.dart';
import 'package:fse_assistant/features/auth/domain/repository/user.dart';
import 'package:fse_assistant/features/auth/presentation/controllers/datasources_providers.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.read(firebaseDataSourceProvider));
});
