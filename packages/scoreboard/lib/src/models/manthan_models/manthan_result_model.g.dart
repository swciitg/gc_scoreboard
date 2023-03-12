// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manthan_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManthanResultModel _$ManthanResultModelFromJson(Map<String, dynamic> json) =>
    ManthanResultModel(
      hostelName: json['hostelName'] as String?,
      primaryScore: (json['primaryScore'] as num?)?.toDouble(),
      secondaryScore: json['secondaryScore'] as String?,
    );

Map<String, dynamic> _$ManthanResultModelToJson(ManthanResultModel instance) =>
    <String, dynamic>{
      'hostelName': instance.hostelName,
      'primaryScore': instance.primaryScore,
      'secondaryScore': instance.secondaryScore,
    };
