import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_test/application/BLoC/trending/trending_bloc.dart';
import 'package:flutter_final_test/application/use_cases/trending/get_trendings.dart';
import 'package:flutter_final_test/domain/movie/movie.dart';
import 'package:flutter_final_test/infrastucture/presentation/config/router/app_router.dart';
import 'package:get_it/get_it.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  late final TrendingsBloc trendingsBloc;
  final getIt = GetIt.instance;

  MovieCard({super.key, required this.movie}) {
    trendingsBloc = TrendingsBloc(
      getTrendingsUseCase: getIt.get<GetTrendingsUseCase>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();

    return GestureDetector(
      onTap: () {
        appNavigator.navigateTo(
            "/detail/${movie.id}/${movie.original_tittle}/${(movie.vote_average * 10).round()}/${movie.poster_path}/${trendingsBloc.state.page}");
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: 280,
          color: Colors.grey,
          child: Stack(
            children: [
              movie.id == 0
                  ? Image.asset(
                      'images/c2.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Image.network(
                      dotenv.env["API_IMAGE"]! + movie.poster_path,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Container(
                            color: Colors.grey,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            ),
                          );
                        }
                      },
                    ),
              Positioned(
                bottom: 10,
                left: 10,
                child: SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '${(movie.vote_average * 10).round()}% User score',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
