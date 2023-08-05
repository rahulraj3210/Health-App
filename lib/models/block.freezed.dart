// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Block _$BlockFromJson(Map<String, dynamic> json) {
  return _Block.fromJson(json);
}

/// @nodoc
mixin _$Block {
  List<House> get houses => throw _privateConstructorUsedError;
  int get id => throw _privateConstructorUsedError;
  int get clusterCount => throw _privateConstructorUsedError;
  String? get docId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlockCopyWith<Block> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockCopyWith<$Res> {
  factory $BlockCopyWith(Block value, $Res Function(Block) then) =
      _$BlockCopyWithImpl<$Res, Block>;
  @useResult
  $Res call({List<House> houses, int id, int clusterCount, String? docId});
}

/// @nodoc
class _$BlockCopyWithImpl<$Res, $Val extends Block>
    implements $BlockCopyWith<$Res> {
  _$BlockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? houses = null,
    Object? id = null,
    Object? clusterCount = null,
    Object? docId = freezed,
  }) {
    return _then(_value.copyWith(
      houses: null == houses
          ? _value.houses
          : houses // ignore: cast_nullable_to_non_nullable
              as List<House>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      clusterCount: null == clusterCount
          ? _value.clusterCount
          : clusterCount // ignore: cast_nullable_to_non_nullable
              as int,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BlockCopyWith<$Res> implements $BlockCopyWith<$Res> {
  factory _$$_BlockCopyWith(_$_Block value, $Res Function(_$_Block) then) =
      __$$_BlockCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<House> houses, int id, int clusterCount, String? docId});
}

/// @nodoc
class __$$_BlockCopyWithImpl<$Res> extends _$BlockCopyWithImpl<$Res, _$_Block>
    implements _$$_BlockCopyWith<$Res> {
  __$$_BlockCopyWithImpl(_$_Block _value, $Res Function(_$_Block) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? houses = null,
    Object? id = null,
    Object? clusterCount = null,
    Object? docId = freezed,
  }) {
    return _then(_$_Block(
      houses: null == houses
          ? _value.houses
          : houses // ignore: cast_nullable_to_non_nullable
              as List<House>,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      clusterCount: null == clusterCount
          ? _value.clusterCount
          : clusterCount // ignore: cast_nullable_to_non_nullable
              as int,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_Block extends _Block {
  const _$_Block(
      {this.houses = const [House(id: 1)],
      this.id = 1,
      this.clusterCount = 0,
      this.docId})
      : super._();

  factory _$_Block.fromJson(Map<String, dynamic> json) =>
      _$$_BlockFromJson(json);

  @override
  @JsonKey()
  final List<House> houses;
  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final int clusterCount;
  @override
  final String? docId;

  @override
  String toString() {
    return 'Block(houses: $houses, id: $id, clusterCount: $clusterCount, docId: $docId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Block &&
            const DeepCollectionEquality().equals(other.houses, houses) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.clusterCount, clusterCount) ||
                other.clusterCount == clusterCount) &&
            (identical(other.docId, docId) || other.docId == docId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(houses), id, clusterCount, docId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BlockCopyWith<_$_Block> get copyWith =>
      __$$_BlockCopyWithImpl<_$_Block>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BlockToJson(
      this,
    );
  }
}

abstract class _Block extends Block {
  const factory _Block(
      {final List<House> houses,
      final int id,
      final int clusterCount,
      final String? docId}) = _$_Block;
  const _Block._() : super._();

  factory _Block.fromJson(Map<String, dynamic> json) = _$_Block.fromJson;

  @override
  List<House> get houses;
  @override
  int get id;
  @override
  int get clusterCount;
  @override
  String? get docId;
  @override
  @JsonKey(ignore: true)
  _$$_BlockCopyWith<_$_Block> get copyWith =>
      throw _privateConstructorUsedError;
}
