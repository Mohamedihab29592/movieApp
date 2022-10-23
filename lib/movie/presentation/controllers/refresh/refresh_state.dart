import 'package:flutter/cupertino.dart';

@immutable
abstract class RefreshBlocState {}

class Loaded extends RefreshBlocState {}

class Loading extends RefreshBlocState{}