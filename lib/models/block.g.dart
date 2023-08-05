// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Block _$$_BlockFromJson(Map<String, dynamic> json) => _$_Block(
      houses: (json['houses'] as List<dynamic>?)
              ?.map((e) => House.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [House(id: 1)],
      id: json['id'] as int? ?? 1,
      clusterCount: json['clusterCount'] as int? ?? 0,
      docId: json['docId'] as String?,
    );

Map<String, dynamic> _$$_BlockToJson(_$_Block instance) => <String, dynamic>{
      'houses': instance.houses.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'clusterCount': instance.clusterCount,
      'docId': instance.docId,
    };
