import 'package:flutter/material.dart' show WidgetsBinding;

/// A wrapper around the method [WidgetsBinding.addPostFrameCallback]
void afterBuild(void Function() doThis){
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {doThis();})
}