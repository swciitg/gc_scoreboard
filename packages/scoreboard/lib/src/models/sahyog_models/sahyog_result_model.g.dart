// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sahyog_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SahyogResultModel _$SahyogResultModelFromJson(Map<String, dynamic> json) =>
    SahyogResultModel(
      hostelName: json['hostelName'] as String?,
      points: (json['points'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SahyogResultModelToJson(SahyogResultModel instance) =>
    <String, dynamic>{
      'hostelName': instance.hostelName,
      'points': instance.points,
    };
