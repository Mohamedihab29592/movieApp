import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/utilies/colors.dart';
import '../../../../core/utilies/constants.dart';
import '../../../../core/utilies/enum.dart';
import '../../../../core/utilies/values_manger.dart';
import '../../screens/movie_detail_screen.dart';

class SeeMoreWidget extends StatelessWidget {
  final String title;
  final RequestState widgetState;
  final int listLength;
  final List<dynamic> movieList;
  final String movieMessage;
  const SeeMoreWidget({Key? key, required this.title, required this.widgetState, required this.listLength, required this.movieList, required this.movieMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return   Scaffold(
        appBar: AppBar(  centerTitle: true,
            title: Text(title)),
        body: SingleChildScrollView(
          child:  ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: listLength,
            itemBuilder: (context, index) {
              final movie = movieList[index];
              return Padding(
                padding: const EdgeInsets.all(AppSize.s10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: AppSize.s8),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MovieDetailScreen(id: movie.id,)));
                        },
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(AppSize.s8)),
                          child: CachedNetworkImage(
                            height: 200,
                            width: 100,
                            fit: BoxFit.cover,
                            imageUrl: AppConstants.imageUrl(movie.backdropPath!),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(AppSize.s8),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: size.width /2,
                            child: Text(movie.title,style: const TextStyle(
                              fontSize: AppSize.s20,
                              fontWeight: FontWeight.bold,
                            ),)),
                        const SizedBox(height: AppSize.s8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSize.s2,
                                horizontal: AppSize.s8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(AppSize.s4),
                              ),
                              child: Text(
                                movie.releaseDate.split('-')[AppSize.s0.toInt()],
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: AppSize.s16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSize.s16),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: AppSize.s20,
                            ),
                            const SizedBox(width: AppSize.s4),
                            Text(
                              ("${movie.voteAverage }/10"),
                              style: const TextStyle(
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: AppSize.s1_2,
                              ),
                            ),
                            const SizedBox(width: AppSize.s4),
                          ],
                        ),
                        const SizedBox(height: AppSize.s8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSize.s2,
                            horizontal: AppSize.s8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softGrey,
                            borderRadius: BorderRadius.circular(AppSize.s4),
                          ),
                          child: Text(
                            "${movie.voteCount} Votes",
                            style: const TextStyle(
                              fontSize: AppSize.s16,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: AppSize.s1_2,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.s8,),
                        Text(
                          "LANG:${movie.originalLanguage.toUpperCase()} ",
                          style: const TextStyle(
                            fontSize: AppSize.s16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            letterSpacing: AppSize.s1_2,
                          ),
                        ),




                      ],
                    ),
                  ],
                ),
              );
            },
          ),


        )



    );
}


}
