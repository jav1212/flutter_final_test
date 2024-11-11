import 'package:flutter/material.dart';
import 'package:flutter_final_test/application/BLoC/trending/trending_bloc.dart';
import 'package:flutter_final_test/application/use_cases/trending/get_trendings.dart';
import 'package:flutter_final_test/infrastucture/presentation/config/router/app_router.dart';
import 'package:get_it/get_it.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  late final TrendingsBloc trendingsBloc;
  final getIt = GetIt.instance;

  CustomAppBar({
    super.key,
    required this.title,
  }) {
    trendingsBloc = TrendingsBloc(
      getTrendingsUseCase: getIt.get<GetTrendingsUseCase>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();

    return AppBar(
      backgroundColor: (appNavigator.currentLocation.contains('/home'))
          ? Colors.white
          : Colors.transparent,
      leading: (!appNavigator.currentLocation.contains('/home'))
          ? IconButton(
              icon: SizedBox(
                width: 24,
                height: 24,
                child: (appNavigator.currentLocation == '/profile')
                    ? Image.asset('images/back_icon.png')
                    : Image.asset('images/close_icon.png'),
              ),
              color: Colors.black,
              onPressed: () => appNavigator.navigateTo("/home"),
            )
          : IconButton(
              icon: SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('images/burger_icon.png'),
              ),
              color: Colors.black,
              onPressed: () => _showFullMenu(context),
            ),
      title: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(
                  blurRadius: 4.0,
                  color: Colors.black45,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          color: Colors.transparent,
          onPressed: () {},
        ),
      ],
    );
  }

  void _showFullMenu(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();

    showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Drawer(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.black,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildHeader(),
                      const Divider(),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _buildMenuItem(
                              context,
                              icon: Icons.home,
                              text: 'Home',
                              onTap: () => appNavigator.navigateTo("/home"),
                            ),
                            _buildMenuItem(
                              context,
                              icon: Icons.person,
                              text: 'Profile',
                              onTap: () => {},
                            ),
                            _buildMenuItem(
                              context,
                              icon: Icons.settings,
                              text: 'Settings',
                              onTap: () => {},
                            ),
                            const Divider(),
                            _buildMenuItem(
                              context,
                              icon: Icons.logout,
                              text: 'Logout',
                              onTap: () => appNavigator.navigateTo("/"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          SizedBox(height: 10),
          Text(
            'User Name',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String text,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: onTap,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40);
}
