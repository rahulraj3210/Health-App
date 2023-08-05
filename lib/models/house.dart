import 'package:freezed_annotation/freezed_annotation.dart';
part 'house.freezed.dart';
part 'house.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class House with _$House {
  const House._();

  @JsonSerializable(explicitToJson: true)
  const factory House({
    @Default(0) int id,
    @Default(false) bool infected,
  }) = _House;
  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);
}
