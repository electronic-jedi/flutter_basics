///
/// Filename: flutter_basics\lib\annotations.dart
/// Created Date: Thursday, December 30th 2021, 1:45:21 am
/// Author: Jedi Hero
///
/// Copyright (c) 2021 Jedi Hero
///

/// Anotations used in this package
library jedi_hero_annotations;

class UnstableApi {
  /// This API is marked as unstable and may be removed.
  const UnstableApi(this.sinceVersion);
  final String sinceVersion;
}
