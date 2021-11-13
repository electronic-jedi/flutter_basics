///
/// Filename: c:\Users\dalit\Desktop\flutter_basics\lib\flutter_basics.dart
/// Path: c:\Users\dalit\Desktop\flutter_basics
/// Created Date: Monday, November 8th 2021, 9:09:43 am
/// Author: Dalitso Sakala
///
/// Copyright (c) 2021 Jedi Hero
///

/// A dart library
@Api("1.0.0")
library flutter_basics;

import 'package:dart_utils/annotations.dart';
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
      viewTarget_ = target;

      /// TODO: Remove this line in a future release
      target_ = target;
      viewIndex_ = index;
      customTitle_ = customTitle;
      actions_ = actions;
      extras_ = extras ?? {};
    });
  }

  /// Typically the method [StatefulWidget.setState]
  @protected
  void Function(Function()) get navigatorStateSetup;

  /// Provides mobility for the commonly used [WillPopScope] widget.
  /// This can  be optionally assigned to the [WillPopScope.onWillPop] argument of the widget.
  /// It only serves as an option and you can choose not to use it.
  @Experimental()
  @Api("1.0.0")
  @protected
  Future<bool> onWillPop_() {
    var pop = false;
    if (viewTarget_ != 0) {
      if (viewIndex_ > 0) {
        setViewIndex(viewIndex_ - 1, target: target_);
      } else {
        setViewIndex(0, target: 0);
      }
    } else {
      pop = true;
    }
    return Future.value(pop);
  }

  /// Indicates target view section that can have different levels.
  /// The various levels are assigned values of [viewIndex_].
  /// The [target_] can have the same value over different values of
  /// [viewIndex_]
  @Api("0.0.0", maxApiVersion: '1.1.0')
  @Deprecated('Use [NavigatorSetup.viewTarget_] instead')
  @protected
  // TODO: Remove this line in a future release
  int target_ = 0;

  /// Indicates target view section that can have different levels.
  /// `(Setting the value directly will be deprecated in a future version)`
  /// The various levels are assigned values of [viewIndex_].
  /// The [viewTarget_] can have the same value over different values of
  /// [viewIndex_]
  @protected
  int viewTarget_ = 0;

  /// Indicates target various navigation depths in a [viewTarget_] aka [target_].
  /// `(Setting the value directly will be deprecated in a future version)`
  /// When the [viewIndex_]==0, another call to [Navigator.pop] has he implication
  /// that the [viewTarget_] aka [target_] has to be changed
  @Api("1.0.0")
  @protected
  var viewIndex_ = 0;

  /// `(Setting the value directly will be deprecated in a future version)`
  @protected
  String? customTitle_;

  /// `(Setting the value directly will be deprecated in a future version)`
  @protected
  List<Widget> actions_ = [];

  /// `(Setting the value directly will be deprecated in a future version)`
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
