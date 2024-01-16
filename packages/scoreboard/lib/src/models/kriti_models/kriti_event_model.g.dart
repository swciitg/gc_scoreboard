// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kriti_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KritiEventModel _$KritiEventModelFromJson(Map<String, dynamic> json) =>
    KritiEventModel(
      id: json['_id'] as String?,
      event: json['event'] as String,
      cup: json['cup'] as String,
      difficulty: json['difficulty'] as String,
      date: DateTime.parse(json['date'] as String),
      clubs: (json['clubs'] as List<dynamic>).map((e) => e as String).toList(),
      venue: json['venue'] as String,
      resultAdded: json['resultAdded'] as bool,
      problemLink: json['problemLink'] as String,
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => KritiResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      victoryStatement: json['victoryStatement'] as String?,
      posterEmail: json['posterEmail'] as String?,
      link: json['link'] as String? ?? '',
    )..points = (json['points'] as num?)?.toDouble();

Map<String, dynamic> _$KritiEventModelToJson(KritiEventModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'event': instance.event,
      'cup': instance.cup,
      'difficulty': instance.difficulty,
      'points': instance.points,
      'date': instance.date.toIso8601String(),
      'clubs': instance.clubs,
      'venue': instance.venue,
      'resultAdded': instance.resultAdded,
      'victoryStatement': instance.victoryStatement,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'posterEmail': instance.posterEmail,
      'problemLink': instance.problemLink,
      'link': instance.link,
    };
