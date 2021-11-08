/// Copyright (c) 2021 Jedi Hero https://www.github.com/jedi-hero.
/// All rights reserved.

library flutter_basics;

import 'package:flutter/material.dart'
    show
        Widget,
        BuildContext,
        MediaQuery,
        MediaQueryData,
        TextTheme,
        Theme,
        ThemeData,
        protected;

/// Utility to ease navigation even on a single widget.
mixin NavigatorSetup {
  void setViewIndex(int index,
      {required int target,
      String? customTitle,
      List<Widget> actions = const [],
      Map<dynamic, dynamic>? extras}) {
    navigatorStateSetup(() {
      target_ = target;
      viewIndex_ = index;
      customTitle_ = customTitle;
      actions_ = actions;
      extras_ = extras ?? {};
    });
  }

  /// Typically the method `setState`
  @protected
  void Function(Function()) get navigatorStateSetup;

  @protected
  int target_ = 0;

  @protected
  var viewIndex_ = 0;

  @protected
  String? customTitle_;

  @protected
  List<Widget> actions_ = [];

  @protected
  Map<dynamic, dynamic> extras_ = {};
}

/// Used to enable the visibility commonly used ui objects.
/// One must include a call to [WidgetBasics.onDidChangeDependencies_] before using the
/// exposed objects namely [WidgetBasics.typography_], [WidgetBasics.theme_] and [WidgetBasics.media_]
mixin WidgetBasics {
  /// Call this method in the [StetefulWidget.didChangeDependencies] stateful widget
  /// method callback to initialize  [typography_], [theme_] and [_media]
  void onDidChangeDependencies_(BuildContext context) {
    theme_ = Theme.of(context);
    typography_ = theme_.textTheme;
    media_ = MediaQuery.of(context);
  }

  late TextTheme typography_;
  late ThemeData theme_;
  late MediaQueryData media_;
}
