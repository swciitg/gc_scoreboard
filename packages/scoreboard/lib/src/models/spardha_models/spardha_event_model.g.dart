// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spardha_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpardhaEventModel _$SpardhaEventModelFromJson(Map<String, dynamic> json) =>
    SpardhaEventModel(
      id: json['_id'] as String?,
      event: json['event'] as String,
      category: json['category'] as String,
      stage: json['stage'] as String,
      date: DateTime.parse(json['date'] as String),
      venue: json['venue'] as String,
      hostels:
          (json['hostels'] as List<dynamic>).map((e) => e as String).toList(),
      status: json['status'] as String,
      results:
          (json['results'] as List<dynamic>?)
              ?.map(
                (e) =>
                    (e as List<dynamic>)
                        .map(
                          (e) => SpardhaResultModel.fromJson(
                            e as Map<String, dynamic>,
                          ),
                        )
                        .toList(),
              )
              .toList() ??
          const [],
      resultAdded: json['resultAdded'] as bool? ?? false,
      victoryStatement: json['victoryStatement'] as String? ?? '',
      link: json['link'] as String? ?? '',
    )..posterEmail = json['posterEmail'] as String?;

Map<String, dynamic> _$SpardhaEventModelToJson(
  SpardhaEventModel instance,
) => <String, dynamic>{
  '_id': instance.id,
  'event': instance.event,
  'category': instance.category,
  'stage': instance.stage,
  'date': instance.date.toIso8601String(),
  'status': instance.status,
  'venue': instance.venue,
  'hostels': instance.hostels,
  'results':
      instance.results.map((e) => e.map((e) => e.toJson()).toList()).toList(),
  'posterEmail': instance.posterEmail,
  'resultAdded': instance.resultAdded,
  'victoryStatement': instance.victoryStatement,
  'link': instance.link,
};
