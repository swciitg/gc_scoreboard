// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) => ResultModel(
      position: json['position'] as int,
      hostel: json['hostel'] as String,
      points: json['points'] as int,
      primaryScore: json['primaryScore'] as String,
      secondaryScore: json['secondaryScore'] as String?,
    );

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'position': instance.position,
      'hostel': instance.hostel,
      'points': instance.points,
      'primaryScore': instance.primaryScore,
      'secondaryScore': instance.secondaryScore,
    };
