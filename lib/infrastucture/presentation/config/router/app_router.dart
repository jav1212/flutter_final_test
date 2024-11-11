import 'package:flutter_final_test/infrastucture/presentation/pages/detail/detail_page.dart';
import 'package:flutter_final_test/infrastucture/presentation/pages/home/home_page.dart';
import 'package:flutter_final_test/infrastucture/presentation/pages/landing/landing_page.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  late final GoRouter _routes;
  final getIt = GetIt.instance;
  String currentLocation = '/';
  final List<String> _previousLocations = [];

  AppNavigator() {
    _routes = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return LandingPage();
          },
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            currentLocation = '/home';
            return HomePage(
              title: "Latest",
            );
          },
        ),
        GoRoute(
          path: '/detail/:id/:title/:score/:image/:page',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            final title = state.pathParameters['title'];
            final score = state.pathParameters['score'];
            final image = state.pathParameters['image'];
            currentLocation = '/detail/$id/$title/$score/$image';
            return DetailPage(
              id: id,
              tittle: title!,
              score: score!,
              title: "",
              image: image!,
            );
          },
        ),
      ],
    );
  }

  get routerDelegate {
    return _routes.routerDelegate;
  }

  get routeInformationParser {
    return _routes.routeInformationParser;
  }

  get routeInformationProvider {
    return _routes.routeInformationProvider;
  }

  bool canPop() {
    if (currentLocation == '/' || currentLocation == '/home') return false;
    return true;
  }

  void pop() {
    if (_previousLocations.isNotEmpty) {
      currentLocation = _previousLocations.removeLast();
      _routes.pop();
    }
  }

  void go(String routeName) {
    currentLocation = routeName;
    _previousLocations.clear();
    _routes.go(routeName);
  }

  void navigateTo(String routeName) {
    _routes.push(routeName);
  }

  void replaceWith(String routeName) {
    _routes.replace(routeName);
  }
}
