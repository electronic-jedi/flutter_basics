// Copyright (c) 2021 Jedi Hero
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

library mixins;

import 'package:flutter/material.dart';

class EJOverlaySettings {
  const EJOverlaySettings({
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.width,
    this.height,
    this.alignment = AlignmentDirectional.topStart,
    this.emptyAreaTap,
  });
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;
  final void Function()? emptyAreaTap;
}

mixin EJOverlay {
  OverlayEntry? _entry;
  BuildContext get context;
  Widget get ejOverlayContent;
  void Function(void Function() fn) get ejSetState;
  EJOverlaySettings get ejOverlaySettings;

  void ejShowOverlay() {
    _buildOverlay();
    Overlay.of(context).insert(_entry!);
  }

  void ejRemoveOverlay() {
    if (_entry?.mounted ?? false) _entry!.remove();
  }

  void _buildOverlay() {
    var d = ejOverlaySettings;
    OverlayEntry e;
    void Function() eat = d.emptyAreaTap ?? ejRemoveOverlay;

    e = OverlayEntry(
      builder: (_) => Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: eat,
          child: Stack(
            children: [
              Positioned(
                left: d.left,
                top: d.top,
                right: d.right,
                bottom: d.bottom,
                child: SizedBox(
                  width: d.width,
                  height: d.height,
                  child: ejOverlayContent,
                ),
              )
            ],
          ),
        ),
      ),
    );
    ejSetState(() => _entry = e);
  }
}
