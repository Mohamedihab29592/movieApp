import 'package:flutter/material.dart';
import 'package:movie_app/core/utilies/values_manger.dart';
import '../../../core/utilies/strings.dart';
import '../widgets/movieSearch/search_body.dart';

class MovieSearch extends StatelessWidget {
  const MovieSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.search),
        centerTitle: true,
      ),
      body:const Padding(
        padding: EdgeInsets.all(AppSize.s20),
        child: SearchBody(isMain: true,),
      ),
    );
  }
}


