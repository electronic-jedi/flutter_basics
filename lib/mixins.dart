// Copyright (c) 2021 Jedi Hero
// 
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

library mixins;

import 'package:flutter/material.dart'
    show
        BuildContext,
        MediaQuery,
        MediaQueryData,
        ScaffoldMessenger,
        ScaffoldMessengerState,
        TextTheme,
        Theme,
        ThemeData,
        Widget;

/// Utility to ease navigation even on a single widget.
mixin NavigatorSetup {
  /// Handle navigation when we want to satisfy the conditions of moving from a view.
  void setViewIndex(int index,
      {required int target,
      String? customTitle,
      List<Widget> actions = const [],
      Map<dynamic, dynamic>? extras}) {
    navigatorStateSetup(() {
      viewTarget_ = target;
      viewIndex_ = index;
      customTitle_ = customTitle;
      actions_ = actions;
      extras_ = extras ?? {};
    });
  }

  /// Typically the method [StatefulWidget.setState].
  /// This enables the [NavigatorSetup] fields to be updated with the state of the [StatefulWidget]
  void Function(Function()) get navigatorStateSetup;

  /// Provides mobility for the commonly used [WillPopScope] widget.
  /// This can  be optionally assigned to the [WillPopScope.onWillPop] argument of the widget.
  /// It only serves as an option and you can choose not to use it.
  Future<bool> onWillPop_() {
    var pop = false;
    if (viewTarget_ > 0) {
      if (viewIndex_ > 0) {
        setViewIndex(viewIndex_ - 1, target: viewTarget_);
      } else {
        setViewIndex(0, target: 0);
      }
    } else if (viewIndex_ > 0) {
      setViewIndex(viewIndex_ - 1, target: 0);
    } else {
      pop = true;
    }
    return Future.value(pop);
  }

  /// Indicates target view section that can have different levels.
  /// The various levels are assigned values of [viewIndex_].
  /// The [viewTarget_] can have the same value over different values of
  /// [viewIndex_]
  int viewTarget_ = 0;

  /// Indicates target various navigation depths in a [viewTarget_] aka [target_].
  /// When the [viewIndex_]==0, another call to [Navigator.pop] has he implication
  /// that the [viewTarget_] aka [target_] has to be changed
  var viewIndex_ = 0;

  String? customTitle_;

  List<Widget> actions_ = [];

  Map<dynamic, dynamic> extras_ = {};
}

/// Used to enable the visibility commonly used ui objects.
/// One must include a call to [WidgetBasics.onDidChangeDependencies_] before using the
/// exposed objects namely [WidgetBasics.typography_], [WidgetBasics.theme_] and [WidgetBasics.media_]
mixin WidgetBasics {
  /// This method must be called.
  /// Call this method in the [StetefulWidget.didChangeDependencies] stateful widget
  /// method callback to initialize  [typography_], [theme_] and [media_]
  void onDidChangeDependencies_(BuildContext context) {
    theme_ = Theme.of(context);
    typography_ = theme_.textTheme;
    media_ = MediaQuery.of(context);
    scaffold_ = ScaffoldMessenger.of(context);
  }

  late TextTheme typography_;
  late ThemeData theme_;
  late MediaQueryData media_;
  late ScaffoldMessengerState scaffold_;
}
