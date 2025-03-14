import 'package:admin_dashboard/constants.dart';
import 'package:admin_dashboard/core/helper/network/dio_clinet.dart';
import 'package:admin_dashboard/core/helper/network/network_info.dart';
import 'package:admin_dashboard/data/addAdmin/repository/repository.dart';
import 'package:admin_dashboard/data/addAdmin/sources/api_services.dart';
import 'package:admin_dashboard/data/addProduct/repo/repo.dart';
import 'package:admin_dashboard/data/addProduct/sources/api_services.dart';
import 'package:admin_dashboard/data/auth/repository/repository.dart';
import 'package:admin_dashboard/data/auth/sources/api_services.dart';
import 'package:admin_dashboard/data/products/repository/repository.dart';
import 'package:admin_dashboard/data/products/sources/api_services.dart';
import 'package:admin_dashboard/domain/addAdmin/repository/repository_impl.dart';
import 'package:admin_dashboard/domain/addAdmin/usecase/usecases.dart';
import 'package:admin_dashboard/domain/addProduct/repo/repo.dart';
import 'package:admin_dashboard/domain/addProduct/usecase/add_product_usecase.dart';
import 'package:admin_dashboard/domain/auth/repository/repository_impl.dart';
import 'package:admin_dashboard/domain/auth/usecase/usecase.dart';
import 'package:admin_dashboard/domain/products/repository/repository_impl.dart';
import 'package:admin_dashboard/domain/products/usecase/delete_product_usecase.dart';
import 'package:admin_dashboard/domain/products/usecase/edit_product_usecase.dart';
import 'package:admin_dashboard/domain/products/usecase/replay_usecase.dart';
import 'package:admin_dashboard/domain/products/usecase/upload_image_use_case.dart';
import 'package:admin_dashboard/domain/products/usecase/usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';

final di = GetIt.instance;

void setUpDi() {
  // DioClient
  di.registerSingleton<DioClient>(DioClient());

  // DioClient الثاني
  di.registerSingleton<DioClient>(
    DioClient(baseUrl: Constants.baseUserManeg),
    instanceName: 'secondaryDioClient', // اسم مميز للـ instance الثاني
  );
  // DioClient الثالث
  di.registerSingleton<DioClient>(
    DioClient(baseUrl: Constants.baseUrlStorage),
    instanceName: 'thirdDioClient', // اسم مميز للـ instance الثاني
  );

  // NetworkInfo
  di.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(InternetConnectionChecker.createInstance()),
  );

  // Supabase.instance
  // di.registerSingleton<Supabase>(Supabase.instance);

  // SharedPreferences
  di.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  // Services
  di.registerSingleton<UserManagementService>(UserManagementServiceImpl());
  di.registerSingleton<AuthService>(AuthServiceImpl());
  di.registerSingleton<ProductService>(ProductsServiceImpl());
  di.registerSingleton<AddProductService>(AddProductServiceImpl());

  // Repositories
  di.registerSingleton<UserManagementRepository>(
    UserManagementRepositoryImpl(),
  );

  di.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  di.registerSingleton<ProductRepository>(ProductRepositoryImpl());

  di.registerSingleton<AddProductRepository>(AddProductRepositoryImpl());

  // Use Cases
  di.registerSingleton<AddAdminUseCase>(AddAdminUseCase());

  di.registerSingleton<AuthUseCase>(AuthUseCase());

  di.registerSingleton<GetProductsUseCase>(GetProductsUseCase());

  di.registerSingleton<UploadImageUseCase>(UploadImageUseCase());

  di.registerSingleton<EditProductUseCse>(EditProductUseCse());
  
  di.registerSingleton<GetCommentsDataUseCase>(GetCommentsDataUseCase());

  di.registerSingleton<ReplayUsecase>(ReplayUsecase());

  di.registerSingleton<DeletProductDateUseCse>(DeletProductDateUseCse());

  di.registerSingleton<AddProductUseCase>(AddProductUseCase());
}
