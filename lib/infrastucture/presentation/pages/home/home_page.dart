import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_test/application/BLoC/trending/trending_bloc.dart';
import 'package:flutter_final_test/application/use_cases/trending/get_trendings.dart';
import 'package:flutter_final_test/infrastucture/presentation/pages/home/widgets/movie_list.dart';
import 'package:flutter_final_test/infrastucture/presentation/widgets/shared/circular_progress_indicator.dart';
import 'package:flutter_final_test/infrastucture/presentation/widgets/shared/ipage.dart';
import 'package:flutter_final_test/infrastucture/presentation/widgets/shared/loading_page.dart';
import 'package:get_it/get_it.dart';

class HomePage extends IPage {
  final getIt = GetIt.instance;
  late final TrendingsBloc trendingsBloc;

  HomePage({
    super.key,
    required super.title,
  }) {
    trendingsBloc = TrendingsBloc(
      getTrendingsUseCase: getIt.get<GetTrendingsUseCase>(),
    );
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    final currentPage = (trendingsBloc.state is TrendingsLoaded)
        ? (trendingsBloc.state as TrendingsLoaded).page
        : 1;
    trendingsBloc.add(FetchTrendingsEvent(page: currentPage));
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(
      create: (context) {
        trendingsBloc.add(FetchTrendingsEvent(page: trendingsBloc.state.page));
        return trendingsBloc;
      },
      child: BlocBuilder<TrendingsBloc, TrendingsState>(
        builder: (context, trendingsState) {
          if (trendingsState is TrendingsLoaded) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    MovieList(movies: trendingsState.trending.movies),
                    const SizedBox(height: 20),
                    PaginationControls(
                      currentPage: trendingsState.page,
                      totalPages: trendingsState.trending.total_pages,
                      onPageChanged: (newPage) {
                        trendingsBloc.add(FetchTrendingsEvent(page: newPage));
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else if (trendingsState is TrendingsLoading) {
            return const Center(child: CustomCircularProgressIndicator());
          } else if (trendingsState is TrendingsFailed) {
            return Center(
              child: ErrorPage(failure: trendingsState.failure!),
            );
          } else {
            return const Center(child: Text("Unknown State"));
          }
        },
      ),
    );
  }
}

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed:
              currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Anterior'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            textStyle: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            'Página $currentPage de $totalPages',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: currentPage < totalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Siguiente'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            textStyle: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
