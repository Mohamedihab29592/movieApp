import 'package:equatable/equatable.dart';

class ProductionCompany extends Equatable{
  final String name;
  final String originCountry;

  const ProductionCompany( { required this.name,required this.originCountry,});

  @override
  List<Object?> get props =>[name,originCountry];
}