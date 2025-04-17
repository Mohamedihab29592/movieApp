import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movie/presentation/controllers/wishList/wish_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utilies/constants.dart';
import '../../../../core/utilies/enum.dart';
import '../../../../core/utilies/strings.dart';
import '../../../../core/utilies/values_manger.dart';

import '../../screens/movie_detail_screen.dart';

class WishlistBody extends StatelessWidget {
  const WishlistBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishBloc, WishState>(
      buildWhen: (previous, current) => previous.wishState != current.wishState,
      builder: (context, state) {
        if (state.wishState == RequestState.error) {
          return Center(
            child: Text(
              state.wishMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        if (state.wishState == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        if (state.wishList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 100,
                  color: Colors.grey[700],
                ),
                const SizedBox(height: 16),
                Text(
                  AppStrings.watchListEmpty,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                  ),
                ),

              ],
            ),
          );
        }

        return FadeIn(
          duration: Duration(milliseconds: AppSize.s500.toInt()),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
            itemCount: state.wishList.length,
            itemBuilder: (context, index) {
              final movie = state.wishList[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(id: movie.id),
                      ),
                    );
                  },
                  child: Container(
                    height: AppSize.s160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Movie Poster
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: AppConstants.imageUrl(movie.posterPath),
                            fit: BoxFit.cover,
                            width: 80,
                            height: 120,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                width: 80,
                                height: 120,
                                color: Colors.black,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        // Movie Info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Movie Title
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                // Rating
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.voteAverage.toStringAsFixed(1),
                                      style: const TextStyle(
                                        color: Colors.amber,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Genre
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.movie_outlined,
                                      color: Colors.grey,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Action", // Replace with actual genre when available
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Year and Duration
                                Row(
                                  children: [
                                    // Year
                                    Icon(
                                      Icons.calendar_today,
                                      color: Colors.grey[400],
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.releaseDate.substring(0, 4), // Extract year from date
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Duration
                                    Icon(
                                      Icons.access_time,
                                      color: Colors.grey[400],
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "139 minutes", // Replace with actual duration when available
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Remove button
                        IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // Dispatch event to remove item from wishlist
                            context.read<WishBloc>().add(RemoveFromWishListEvent(movieId: movie.id));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}