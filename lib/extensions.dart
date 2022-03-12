// Copyright (c) 2022 Jedi Hero
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

import 'package:flutter/material.dart';

extension GlobalKeyUtils on GlobalKey {
  Size? get size_ {
    final box = currentContext?.findRenderObject() as RenderBox?;
    return box?.size;
  }
}
