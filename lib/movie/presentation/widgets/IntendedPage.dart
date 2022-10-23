import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/refresh/refresh_bloc.dart';
import '../controllers/refresh/refresh_event.dart';


class IntendedPage extends StatelessWidget {
  const IntendedPage({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final refreshBloc = BlocProvider.of<RefreshBlocBloc>(context);

    return RefreshIndicator(
      // Here we call that [RefreshEvent] in [RefreshBlocBloc]
      onRefresh: () async {
        refreshBloc.add(RefreshEvnt());
      },
      child: SingleChildScrollView(
        // To make RefreshIndicator work, it child widget should scroll, thats why I added [AlwaysScrollableScrollPhysics]
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),

        // You can fill this with anyting you like, or even you can use [ListView]
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.refresh,
                color: Theme.of(context).primaryColor,
                size: 100,
              ),
              const SizedBox(height: 24),
              Text(
                'Pull Down to Refresh',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}