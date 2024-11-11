import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_test/application/BLoC/credit/credit_bloc.dart';
import 'package:flutter_final_test/application/use_cases/credit/get_credit_by_movie.dart';
import 'package:flutter_final_test/infrastucture/presentation/pages/detail/widgets/actor_grid.dart';
import 'package:flutter_final_test/infrastucture/presentation/widgets/shared/ipage.dart';
import 'package:get_it/get_it.dart';

class DetailPage extends IPage {
  final int id;
  final String tittle;
  final String score;
  final String image;
  final getIt = GetIt.instance;
  late final CreditsBloc creditsBloc;

  DetailPage({
    super.key,
    required this.id,
    required this.tittle,
    required this.score,
    required this.image,
    required super.title,
  }) {
    creditsBloc = CreditsBloc(
      getCreditByMovieUseCase: getIt.get<GetCreditByMovieUseCase>(),
    );
  }

  @override
  Widget child(BuildContext context) {
    return DetailPageContent(
      id: id,
      tittle: tittle,
      score: score,
      image: image,
    );
  }

  @override
  Future<void> onRefresh() async {
    creditsBloc.add(FetchCreditEvent(movieId: id));
  }
}

class DetailPageContent extends StatelessWidget {
  final int id;
  final String tittle;
  final String score;
  final String image;

  final ValueNotifier<bool> isClickedNotifier = ValueNotifier(false);

  DetailPageContent({
    super.key,
    required this.id,
    required this.tittle,
    required this.score,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final creditsBloc = CreditsBloc(
      getCreditByMovieUseCase: getIt.get<GetCreditByMovieUseCase>(),
    );

    return BlocProvider(
      create: (context) {
        creditsBloc.add(FetchCreditEvent(movieId: id));
        return creditsBloc;
      },
      child: BlocBuilder<CreditsBloc, CreditState>(
        builder: (context, creditsState) {
          if (creditsState is CreditLoaded) {
            return SafeArea(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      isClickedNotifier.value = !isClickedNotifier.value;
                    },
                    child: _buildMovieImage(context),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: isClickedNotifier,
                    builder: (context, isClicked, child) {
                      return isClicked
                          ? _buildMovieDetails(context, creditsState)
                          : Container();
                    },
                  ),
                ],
              ),
            );
          } else if (creditsState is CreditLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (creditsState is CreditFailed) {
            return Center(child: Text("Error: ${creditsState.failure}"));
          } else {
            return const Center(child: Text("Unknown State"));
          }
        },
      ),
    );
  }

  Widget _buildMovieImage(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.network(
        dotenv.env["API_IMAGE"]! + image,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildMovieDetails(BuildContext context, CreditLoaded creditsState) {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 20,
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                tittle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$score% User score',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            ActorGrid(actors: creditsState.credit.cast),
          ],
        ),
      ),
    );
  }
}
