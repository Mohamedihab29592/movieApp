import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utilies/strings.dart';
import '../controllers/wishList/wish_bloc.dart';
import '../widgets/wishlist/wishlist_body.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => WishBloc(sl(),sl(),sl())..add(GetWishListEvent()),


      child: Scaffold(
        appBar:  AppBar(
        elevation: 0,
        title: const Text(
          AppStrings.watchList,
        ),
        centerTitle: true,

      ),
        body: const WishlistBody(),
      ),
    );
  }
}
