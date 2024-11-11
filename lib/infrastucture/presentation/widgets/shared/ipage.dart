import 'package:flutter/material.dart';
import 'package:flutter_final_test/infrastucture/presentation/widgets/shared/custom_app_bar.dart';

abstract class IPage extends StatelessWidget {
  final String title;

  const IPage({super.key, required this.title});

  Widget child(BuildContext context);

  Future<void> onRefresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: onRefresh,
              child: Stack(
                children: [
                  child(context),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomAppBar(
                title: title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
