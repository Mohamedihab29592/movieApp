import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utilies/strings.dart';
import 'package:movie_app/core/utilies/constants.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utilies/assets.dart';
import '../../../core/utilies/colors.dart';
import '../../../core/utilies/enum.dart';
import '../../domain/entities/genres.dart';
import '../controllers/movieDetails/movie_details_bloc.dart';
import '../controllers/movieDetails/movie_details_event.dart';
import '../controllers/movieDetails/movie_details_state.dart';
import '../controllers/wishList/wish_bloc.dart';
import '../widgets/movieDetails/about_movie.dart';
import '../widgets/movieDetails/cast_show.dart';
import '../widgets/movieDetails/review_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(
        create: (context) => MovieDetailsBloc(sl(), sl(), sl())
          ..add(GetMovieDetailsEvent(widget.id))
          ..add(GetCastEvent(widget.id))
          ..add(GetReviewEvent(widget.id))),
        BlocProvider(
          create: (context) => WishBloc(sl(),sl(),sl()),

        ),
        ],
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)
            ),
            title: const Text(
              AppStrings.detail,
            ),
            centerTitle: true,
            actions: [
              BlocBuilder<WishBloc, WishState>(
                builder: (context, wishlistState) {
                  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(

                    builder: (context, movieState) {
                      final movieDetails = movieState.movieDetails;
                      final isInWishlist = wishlistState.wishList.any((m) => m.id == widget.id);

                      return IconButton(
                        onPressed: () {
                          if (movieDetails != null) {
                            final wishBloc = context.read<WishBloc>();
                            if (isInWishlist) {
                              wishBloc.add(RemoveFromWishListEvent(movieId: widget.id));
                            } else {
                              wishBloc.add(AddToWishListEvent(movie: movieDetails));
                            }
                          }
                        },
                        icon: ImageIcon(
                          isInWishlist? const AssetImage(Assets.wishListIconRe):const AssetImage(Assets.wishListIcon),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: MovieDetailContent(id: widget.id, tabController: _tabController),
        ),
      );

  }
}

class MovieDetailContent extends StatelessWidget {
  final int id;
  final TabController tabController;

  const MovieDetailContent({
    Key? key,
    required this.id,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator.adaptive(
              ),
            );
          case RequestState.loaded:
            return Column(
              children: [
                _buildMovieHeader(state),

                _buildTabBar(),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      AboutMovieWidget(state:state),
                      ReviewsWidget(reviews:state.movieReview),
                      GridCastView(id: id),
                    ],
                  ),
                ),

              ],
            );
          case RequestState.error:
            return Center(
              child: Text(
                state.movieDetailsMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
        }
      },
    );
  }

  Widget _buildMovieHeader(MovieDetailsState state) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: 240,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                AppConstants.imageUrl(state.movieDetails!.backdropPath),
              ),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withAlpha(200),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Movie poster
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 100,
                  height: 140,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: AppConstants.imageUrl(state.movieDetails!.posterPath),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[800],
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.movieDetails!.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          state.movieDetails!.releaseDate.split('-')[0],
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.access_time,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _showDuration(state.movieDetails!.runtime),
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          _showGenreShort(state.movieDetails!.genres),
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          state.movieDetails!.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      dividerColor: Colors.transparent,

      controller: tabController,
      labelColor: Colors.white,
      indicatorColor: AppColors.softGrey,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs:  const [
        Tab(text: AppStrings.about),
        Tab(text:  AppStrings.reviews),
        Tab(text:  AppStrings.cast),
      ],
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  String _showGenreShort(List<Genres> genres) {
    if (genres.isEmpty) return '';
    return genres.first.name;
  }

}

