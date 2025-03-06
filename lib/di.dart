import 'package:admin_dashboard/core/helper/network/dio_clinet.dart';
import 'package:admin_dashboard/core/helper/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final di = GetIt.instance;

void setUpDi() {
  // DioClient
  di.registerSingleton<DioClient>(DioClient());

  // NetworkInfo
  di.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(InternetConnectionChecker.createInstance()),
  );

  // Supabase.instance
  di.registerSingleton<Supabase>(Supabase.instance);

  // Services

  // Repositories

  // Use Cases

}
