// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manthan_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManthanEventModel _$ManthanEventModelFromJson(Map<String, dynamic> json) =>
    ManthanEventModel(
      id: json['_id'] as String?,
      event: json['event'] as String,
      module: json['module'] as String,
      date: DateTime.parse(json['date'] as String),
      venue: json['venue'] as String,
      results: (json['results'] as List<dynamic>?)
              ?.map(
                  (e) => ManthanResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      resultAdded: json['resultAdded'] as bool? ?? false,
      victoryStatement: json['victoryStatement'] as String? ?? '',
      link: json['link'] as String? ?? '',
    )..posterEmail = json['posterEmail'] as String?;

Map<String, dynamic> _$ManthanEventModelToJson(ManthanEventModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'event': instance.event,
      'module': instance.module,
      'date': instance.date.toIso8601String(),
      'venue': instance.venue,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'posterEmail': instance.posterEmail,
      'resultAdded': instance.resultAdded,
      'victoryStatement': instance.victoryStatement,
      'link': instance.link,
    };
