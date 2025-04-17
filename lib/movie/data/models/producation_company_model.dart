
import '../../domain/entities/prodication_company.dart';

class ProductionCompanyModel extends ProductionCompany{
  const ProductionCompanyModel({ required super.name ,required super.originCountry});
  factory ProductionCompanyModel.fromJson(Map<String,dynamic>json) =>ProductionCompanyModel
    (name: json["name"], originCountry:json["origin_country"]);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "origin_country": originCountry,
    };
  }
}