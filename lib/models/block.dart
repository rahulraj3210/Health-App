import 'package:freezed_annotation/freezed_annotation.dart';
import 'house.dart';
part 'block.freezed.dart';
part 'block.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Block with _$Block {
  const Block._();
  @JsonSerializable(explicitToJson: true)
  const factory Block({
    @Default([House(id: 1)]) List<House> houses,
    @Default(1) int id,
    @Default(0) int clusterCount,
    @Default([]) List<List<House>> clusters,
    String? docId,
  }) = _Block;
  factory Block.fromJson(Map<String, dynamic> json) => _$BlockFromJson(json);
}
