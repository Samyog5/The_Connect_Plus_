import 'package:tcp/core/localization/locale_provider.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/auth_remote_data_source_impl.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_user.dart';
import 'presentation/bloc/auth_bloc.dart';

// Simple service locator map
final _services = <Type, dynamic>{};

// Export for use in main
Map<Type, dynamic> getServices() => _services;

void _registerService<T>(T instance) {
  _services[T] = instance;
}

void setupAuthInjection() {
  // Localization Provider (Singleton)
  final localeProvider = LocaleProvider();
  _registerService<LocaleProvider>(localeProvider);

  // Data Sources
  final remoteDataSource = AuthRemoteDataSourceImpl();
  _registerService<AuthRemoteDataSource>(remoteDataSource);

  // Repositories
  final repository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);
  _registerService<AuthRepository>(repository);

  // Use Cases
  final loginUser = LoginUser(repository);
  _registerService<LoginUser>(loginUser);

  // BLoCs
  final authBloc = AuthBloc(loginUser: loginUser);
  _registerService<AuthBloc>(authBloc);
}

// Helper function to get LocaleProvider
LocaleProvider getLocaleProvider() {
  return _services[LocaleProvider] as LocaleProvider;
}
