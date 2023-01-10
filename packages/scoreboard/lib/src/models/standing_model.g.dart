// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingModel _$StandingModelFromJson(Map<String, dynamic> json) =>
    StandingModel(
      event: json['event'] as String?,
      category: json['category'] as String?,
      standings: (json['standings'] as List<dynamic>?)
          ?.map((e) => HostelPoints.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..id = json['_id'] as String?;

Map<String, dynamic> _$StandingModelToJson(StandingModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'event': instance.event,
      'category': instance.category,
      'standings': instance.standings?.map((e) => e.toJson()).toList(),
    };
