import 'package:flutter/material.dart' show WidgetsBinding;

/// A wrapper around the method [WidgetsBinding.addPostFrameCallback] but without the timestamp argument
void afterBuild(void Function() doThis) {
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    doThis();
  });
}

/// A wrapper around the method [WidgetsBinding.addPostFrameCallback]
void afterBuildStamp(void Function(Duration) doThis) {
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    doThis(timeStamp);
  });
}
