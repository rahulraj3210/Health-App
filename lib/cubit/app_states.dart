part of 'app_cubits.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class CubitState with _$CubitState {
  const CubitState._();

  const factory CubitState({
    @Default([]) List<House> houses,
    @Default(0) int totalCluster,
  }) = _CubitState;
}
