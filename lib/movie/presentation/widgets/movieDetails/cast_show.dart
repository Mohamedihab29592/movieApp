import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utilies/constants.dart';
import 'package:movie_app/movie/presentation/controllers/movieDetails/movie_details_bloc.dart';
import 'package:movie_app/movie/presentation/controllers/movieDetails/movie_details_state.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utilies/strings.dart';
import '../../../../core/utilies/values_manger.dart';

class GridCastView extends StatelessWidget {
  final int id;

  const GridCastView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        if (state.cast.isEmpty){
          return  const Center(
            child: Text(
              AppStrings.castListEmpty,
              style: TextStyle(color: Colors.grey),
            ),
          );

        }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.cast,
                  style: TextStyle(
                    fontSize: AppSize.s20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: AppSize.s1_2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.cast.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: const Icon(Icons.image, size: 50),
                                ),
                              ),
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageProvider,
                                  ),
                                ),
                              ),
                              imageUrl: AppConstants.imageUrl(state.cast[index].image!),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.cast[index].name,
                            style: const TextStyle(
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),

                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );



      },
    );
  }
}