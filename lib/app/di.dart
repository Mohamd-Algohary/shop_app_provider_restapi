import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/admin_dashboard_screen/edit_product_screen/viewmodel/viewmodel.dart';
import '../presentation/admin_dashboard_screen/viewmodel/viewmodel.dart';
import '/presentation/cart_screen/viewmodel/viewmodel.dart';
import '../domain/models/cart.dart';
import '/app/themes_services.dart';
import '/presentation/home_screen/viewmodel/viewmodel.dart';
import '../domain/usecase/add_order_usecase.dart';
import '../domain/usecase/add_product_usecase.dart';
import '../domain/usecase/delete_order_usecase.dart';
import '../domain/usecase/delete_product_usecase.dart';
import '../domain/usecase/fetch_orders_usecase.dart';
import '../domain/usecase/get_products_usecase.dart';
import '../domain/usecase/get_user_fav_usecase.dart';
import '../domain/usecase/toggel_fav_status_usecase.dart';
import '../domain/usecase/update_order_usecase.dart';
import '../domain/usecase/update_product_usecase.dart';
import '../presentation/orders_screen/viewmodel/viewmodel.dart';
import '/app/app_prefs.dart';
import '/data/api/auth_api.dart';
import '/data/api/dio_factory.dart';
import '/data/api/network_info.dart';
import '/data/data_scource/remote_data_source.dart';
import '/data/repo_impl/repo_impl.dart';
import '/domain/repository/repository.dart';
import '/domain/usecase/login_usecase.dart';
import '/domain/usecase/register_usecase.dart';
import '/presentation/auth_screen/viewmodel/viewmodel.dart';
import '../data/api/data_api.dart';

final instance = GetIt.instance;

Future<void> initModule() async {
  Hive.registerAdapter(CartProductAdapter());
  var box = await Hive.openBox<CartProduct>('cartBox');
  instance.registerLazySingleton<CartViewModel>(() => CartViewModel(box));

  SharedPreferences pref = await SharedPreferences.getInstance();
  instance.registerLazySingleton<AppPreference>(() => AppPreference(pref));

  instance.registerLazySingleton<ThemesService>(() => ThemesService(pref));

  Connectivity connectivity = Connectivity();
  instance
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity));

  Dio dio = await DioFactory().getDio();
  instance.registerLazySingleton<AuthAppServiceClient>(
      () => AuthAppServiceClient(dio));
  instance.registerLazySingleton<DataAppServiceClient>(
      () => DataAppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance(), instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

void initAuthModule() {
  if (!GetIt.I.isRegistered<AuthViewModel>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<AuthViewModel>(
        () => AuthViewModel(instance(), instance(), instance()));
  }
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<HomeViewModel>()) {
    instance.registerFactory<GetProductsUseCase>(
        () => GetProductsUseCase(instance()));
    instance.registerFactory<GetUserFavUseCase>(
        () => GetUserFavUseCase(instance()));
    instance.registerFactory<ToggelFavStatusUseCase>(
        () => ToggelFavStatusUseCase(instance()));
    instance.registerLazySingleton<HomeViewModel>(
        () => HomeViewModel(instance(), instance(), instance(), instance()));
  }
}

void initEditProductModule() {
  if (!GetIt.I.isRegistered<EditProductViewModel>()) {
    instance.registerFactory<AddProductUseCase>(
        () => AddProductUseCase(instance()));
    instance.registerFactory<UpdateProductUseCase>(
        () => UpdateProductUseCase(instance()));
    instance.registerFactory<EditProductViewModel>(
        () => EditProductViewModel(instance(), instance(), instance()));
  }
}

void initOrdersModule() {
  if (!GetIt.I.isRegistered<OrdersViewModel>()) {
    instance.registerFactory<FetchOrdersUseCase>(
        () => FetchOrdersUseCase(instance()));
    instance
        .registerFactory<AddOrderUseCase>(() => AddOrderUseCase(instance()));
    instance.registerFactory<UpdateOrderUseCase>(
        () => UpdateOrderUseCase(instance()));
    instance.registerFactory<DeleteOrderUseCase>(
        () => DeleteOrderUseCase(instance()));
    instance.registerFactory<OrdersViewModel>(() => OrdersViewModel(
        instance(), instance(), instance(), instance(), instance()));
  }
}

void initUserProductsModule() {
  if (!GetIt.I.isRegistered<AdminDashboardViewModel>()) {
    instance.registerFactory<DeleteProductUseCase>(
        () => DeleteProductUseCase(instance()));
    instance.registerFactory<AdminDashboardViewModel>(
        () => AdminDashboardViewModel(instance(), instance()));
  }
}
