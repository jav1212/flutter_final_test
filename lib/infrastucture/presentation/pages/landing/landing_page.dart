import 'package:flutter/material.dart';
import 'package:flutter_final_test/application/BLoC/trending/trending_bloc.dart';
import 'package:flutter_final_test/infrastucture/presentation/config/router/app_router.dart';
import 'package:get_it/get_it.dart';

class LandingPage extends StatelessWidget {
  final getIt = GetIt.instance;
  late final TrendingsBloc trendingsBloc;

  LandingPage({super.key}) {
    trendingsBloc = getIt.get<TrendingsBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(context, isPortrait),
              SizedBox(height: screenHeight * 0.04),
              _buildFeaturesSection(screenWidth),
              SizedBox(height: screenHeight * 0.06),
              _buildCallToAction(context),
              SizedBox(height: screenHeight * 0.08),
              _buildFooter(context),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isPortrait) {
    final double height = isPortrait
        ? MediaQuery.of(context).size.height * 0.6
        : MediaQuery.of(context).size.height * 0.4;
    final double fontSize = isPortrait ? 30 : 24;

    return SizedBox(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://picsum.photos/1920/1080',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, object, stackTrace) {
              return const Center(child: Icon(Icons.error, size: 48));
            },
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                child: child,
              );
            },
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Avila Tek Technical Test',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Stream thousands of movies and TV shows now!',
                  style: TextStyle(
                      fontSize: fontSize * 0.6, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Why Choose CinemaHub?',
            style: TextStyle(
                fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenWidth * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeatureItem(
                  Icons.cloud_download, 'Offline Viewing', screenWidth),
              _buildFeatureItem(
                  Icons.people_alt, 'Multi-User Profiles', screenWidth),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text, double screenWidth) {
    return Column(
      children: [
        Icon(icon, size: screenWidth * 0.08, color: Colors.redAccent),
        SizedBox(height: screenWidth * 0.01),
        Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: screenWidth * 0.04)),
      ],
    );
  }

  Widget _buildCallToAction(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    final double buttonHeight = MediaQuery.of(context).size.height * 0.07;
    final appNavigator = getIt.get<AppNavigator>();

    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.redAccent),
          minimumSize: WidgetStateProperty.all(Size(buttonWidth, buttonHeight)),
        ),
        onPressed: () {
          appNavigator.navigateTo('/home');
        },
        child: Text('Start Your Free Trial',
            style: TextStyle(fontSize: buttonHeight * 0.45)),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Popular Genres',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05)),
          SizedBox(height: screenWidth * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGenreChip('Action', screenWidth),
              _buildGenreChip('Comedy', screenWidth),
              _buildGenreChip('Drama', screenWidth),
              _buildGenreChip('Horror', screenWidth),
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          Text('Copyright 2024 CinemaHub',
              style:
                  TextStyle(color: Colors.grey, fontSize: screenWidth * 0.035)),
        ],
      ),
    );
  }

  Widget _buildGenreChip(String genre, double screenWidth) {
    return Chip(
      label: Text(genre, style: TextStyle(fontSize: screenWidth * 0.035)),
      backgroundColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
