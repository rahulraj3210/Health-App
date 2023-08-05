// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'house.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

House _$HouseFromJson(Map<String, dynamic> json) {
  return _House.fromJson(json);
}

/// @nodoc
mixin _$House {
  int get id => throw _privateConstructorUsedError;
  bool get infected => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HouseCopyWith<House> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HouseCopyWith<$Res> {
  factory $HouseCopyWith(House value, $Res Function(House) then) =
      _$HouseCopyWithImpl<$Res, House>;
  @useResult
  $Res call({int id, bool infected});
}

/// @nodoc
class _$HouseCopyWithImpl<$Res, $Val extends House>
    implements $HouseCopyWith<$Res> {
  _$HouseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? infected = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      infected: null == infected
          ? _value.infected
          : infected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HouseCopyWith<$Res> implements $HouseCopyWith<$Res> {
  factory _$$_HouseCopyWith(_$_House value, $Res Function(_$_House) then) =
      __$$_HouseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, bool infected});
}

/// @nodoc
class __$$_HouseCopyWithImpl<$Res> extends _$HouseCopyWithImpl<$Res, _$_House>
    implements _$$_HouseCopyWith<$Res> {
  __$$_HouseCopyWithImpl(_$_House _value, $Res Function(_$_House) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? infected = null,
  }) {
    return _then(_$_House(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      infected: null == infected
          ? _value.infected
          : infected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_House extends _House {
  const _$_House({this.id = 0, this.infected = false}) : super._();

  factory _$_House.fromJson(Map<String, dynamic> json) =>
      _$$_HouseFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final bool infected;

  @override
  String toString() {
    return 'House(id: $id, infected: $infected)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_House &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.infected, infected) ||
                other.infected == infected));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, infected);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HouseCopyWith<_$_House> get copyWith =>
      __$$_HouseCopyWithImpl<_$_House>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HouseToJson(
      this,
    );
  }
}

abstract class _House extends House {
  const factory _House({final int id, final bool infected}) = _$_House;
  const _House._() : super._();

  factory _House.fromJson(Map<String, dynamic> json) = _$_House.fromJson;

  @override
  int get id;
  @override
  bool get infected;
  @override
  @JsonKey(ignore: true)
  _$$_HouseCopyWith<_$_House> get copyWith =>
      throw _privateConstructorUsedError;
}
