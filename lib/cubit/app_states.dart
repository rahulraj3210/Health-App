part of 'app_cubits.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class CubitState with _$CubitState {
  const CubitState._();

  const factory CubitState({
    @Default([]) List<Block> blocks,
    @Default(0) int currentBlockIndex,
  }) = _CubitState;
}
