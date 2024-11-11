import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_test/application/BLoC/connectivity/connectivity_bloc.dart';
import 'package:flutter_final_test/application/BLoC/credit/credit_bloc.dart';
import 'package:flutter_final_test/application/BLoC/trending/trending_bloc.dart';
import 'package:flutter_final_test/application/use_cases/credit/get_credit_by_movie.dart';
import 'package:flutter_final_test/application/use_cases/trending/get_trendings.dart';
import 'package:flutter_final_test/infrastucture/datasources/api/api_connection_manager_impl.dart';
import 'package:flutter_final_test/infrastucture/presentation/config/router/app_router.dart';
import 'package:flutter_final_test/infrastucture/repositories/credit/credit_repository_impl.dart';
import 'package:flutter_final_test/infrastucture/repositories/trending/trending_repository_impl.dart';
import 'package:flutter_final_test/infrastucture/services/network/network_manager_impl.dart';
import 'package:get_it/get_it.dart';

class SetupInjections {
  static Future<void> exec() async {
    WidgetsFlutterBinding.ensureInitialized();
    //loading env
    await dotenv.load(fileName: ".env");

    //loading network manager
    final networkManagerImpl = NetworkManagerImpl(connectivity: Connectivity());

    //api manager setup
    final apiConnectionManagerImpl = ApiConnectionManagerImpl(
      baseUrl: dotenv.env['API_URL']!,
    );
    apiConnectionManagerImpl.setHeaders('accept', 'application/json');

    //repositories setup
    final creditRepository = CreditRepositoryImpl(
      apiConnectionManager: apiConnectionManagerImpl,
    );

    final trendingRepository = TrendingRepositoryImpl(
      apiConnectionManager: apiConnectionManagerImpl,
    );

    //use cases setup
    final GetTrendingsUseCase getTrendingsUseCase =
        GetTrendingsUseCase(trendingRepository: trendingRepository);
    final GetCreditByMovieUseCase getCreditByMovieUseCase =
        GetCreditByMovieUseCase(creditRepository: creditRepository);

    //singleton access to use cases
    final getIt = GetIt.instance;
    getIt.registerSingleton<GetTrendingsUseCase>(getTrendingsUseCase);
    getIt.registerSingleton<GetCreditByMovieUseCase>(getCreditByMovieUseCase);

    //router config
    getIt.registerSingleton<AppNavigator>(AppNavigator());

    //bloc config
    getIt.registerSingleton<ConnectivityBloc>(
        ConnectivityBloc(networkManager: networkManagerImpl));
    getIt.registerLazySingleton<TrendingsBloc>(() => TrendingsBloc(
          getTrendingsUseCase: getIt.get<GetTrendingsUseCase>(),
        ));
    getIt.registerLazySingleton<CreditsBloc>(() => CreditsBloc(
          getCreditByMovieUseCase: getIt.get<GetCreditByMovieUseCase>(),
        ));
  }
}
