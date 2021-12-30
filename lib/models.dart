//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

library models;

import 'package:flutter/material.dart' show ChangeNotifier;

class ValueModel<T> with ChangeNotifier {
  /// A model for a scenario where typically one value is required from a parent.
  ValueModel({required T value}) : _value = value {
    setGetter(() => _value);
  }
  void setGetter(T Function() getter) {
    _getter = getter;
    notifyListeners();
  }

  void setValue(T value) {
    _value = value;
    notifyListeners();
  }

  T get value => _getter();
  T _value;
  late T Function() _getter;
}
