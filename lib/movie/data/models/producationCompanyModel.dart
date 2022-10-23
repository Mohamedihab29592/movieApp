
import '../../domain/entities/prodicationCompany.dart';

class ProductionCompanyModel extends ProductionCompany{
  const ProductionCompanyModel({ required super.name ,required super.originCountry});
  factory ProductionCompanyModel.fromJson(Map<String,dynamic>json) =>ProductionCompanyModel
    (name: json["name"], originCountry:json["origin_country"]);
}