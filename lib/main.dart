import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_test/application/BLoC/connectivity/connectivity_bloc.dart';
import 'package:flutter_final_test/common/failure.dart';
import 'package:flutter_final_test/infrastucture/presentation/config/router/app_router.dart';
import 'package:flutter_final_test/infrastucture/presentation/config/theme/app_theme.dart';
import 'package:flutter_final_test/infrastucture/presentation/widgets/bloc_listener/network_listener.dart';
import 'package:flutter_final_test/infrastucture/presentation/widgets/shared/loading_page.dart';
import 'package:flutter_final_test/infrastucture/services/config/setup_injections.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  try {
    await SetupInjections.exec();
    runApp(const MyApp());
  } catch (e) {
    runApp(const ErrorPage(failure: UnknownFailure()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();

    return MaterialApp.router(
      title: dotenv.env['APP_NAME']!,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerDelegate: appNavigator.routerDelegate,
      routeInformationParser: appNavigator.routeInformationParser,
      routeInformationProvider: appNavigator.routeInformationProvider,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<ConnectivityBloc>()),
          ],
          child:
              MultiBlocListener(listeners: [NetworkListener()], child: child!),
        );
      },
    );
  }
}
