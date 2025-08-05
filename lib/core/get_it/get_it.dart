import 'package:get_it/get_it.dart';
import 'package:hello/core/datasource/auth_remote_datasource.dart';
import 'package:hello/core/repository/auth_reporsitory.dart';
import 'package:hello/core/repository_impl/auth_repository_impl.dart';

import '../../feature/layout/cart/bloc/cart_bloc.dart';
import '../../feature/layout/home/bloc/product_bloc.dart';
import '../../feature/layout/login/bloc/auth_bloc.dart';
import '../../feature/layout/profile/bloc/profile_bloc.dart';
import '../../sqlite/database_helper.dart';
import '../api/api_.dart';
import '../datasource/product_remote_datasource.dart';
import '../repository/product_repository.dart';
import '../repository_impl/product_repository_impl.dart';

final getIt = GetIt.instance;

void setup() {
  registerApiClient();
  registerDatabaseHelper();     // ✅ Đăng ký DatabaseHelper trước
  registerDataSource();         // ✅ Sau đó dùng nó để tạo Datasource
  registerRepositories();       // ✅ Repositories cần Datasource
  registerBloc();               // ✅ Cuối cùng là các Bloc
}

void registerApiClient() {
  getIt.registerSingleton(ApiClient());
}

void registerDatabaseHelper() {
  getIt.registerSingleton<DatabaseHelper>(DatabaseHelper.instance);
}

void registerDataSource() {
  //final dio = getIt<ApiClient>().getDio();
  final dioWithToken = getIt<ApiClient>().getDio(tokenInterceptor: true);

  getIt.registerSingleton<ProductRemoteDatasource>(
    ProductRemoteDatasource(
      databaseHelper: getIt<DatabaseHelper>(),
    ),
  );

  getIt.registerSingleton<AuthRemoteDatasource>(
    AuthRemoteDatasource(databaseHelper: getIt<DatabaseHelper>()),
  );
}

void registerRepositories() {
  // ❌ Không cần đăng ký lại DatabaseHelper nữa ở đây

  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(
      productRemoteDatasource: getIt<ProductRemoteDatasource>(),
    ),
  );

  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authRemoteDatasource: getIt<AuthRemoteDatasource>(),
      databaseHelper: getIt<DatabaseHelper>(),
    ),
  );
}

void registerBloc() {
  getIt.registerFactory(
        () => ProductBloc(productRepository: getIt<ProductRepository>()),
  );

  getIt.registerSingleton<AuthBloc>(
    AuthBloc(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerSingleton<CartBloc>(
    CartBloc(databaseHelper: getIt<DatabaseHelper>()),
  );

  getIt.registerSingleton<ProfileBloc>(
    ProfileBloc(databaseHelper: getIt<DatabaseHelper>()),
  );
}
