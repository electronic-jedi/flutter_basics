// Copyright (c) 2023 Jedi Hero
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

class EJDropdown extends StatelessWidget {
  const EJDropdown(
    this.items, {
    super.key,
    this.onChanged,
    this.hint,
    this.radius = 3,
    this.expand = false,
    this.width,
    this.borderColor = Colors.grey,
  });
  final String? hint;
  final List<dynamic> items;
  final double radius;
  final bool expand;
  final double? width;
  final Color borderColor;
  final void Function(dynamic)? onChanged;
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> items_ = [];
    var expand_ = width != null ? true : expand;
    for (var item in items) {
      items_.add(DropdownMenuItem(child: Text('$item')));
    }
    return Container(
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(radius)),
      child: DropdownButton(
        items: items_,
        onChanged: onChanged,
        isExpanded: expand_,
        hint: hint != null ? Text(hint!) : null,
        borderRadius: BorderRadius.circular(radius),
        underline: SizedBox(),
      ),
    );
  }
}

Column EJColumn(
  List<Widget> children, {
  MainAxisAlignment main = MainAxisAlignment.start,
  CrossAxisAlignment cross = CrossAxisAlignment.start,
  MainAxisSize size = MainAxisSize.max,
}) {
  return Column(
    mainAxisAlignment: main,
    crossAxisAlignment: cross,
    mainAxisSize: size,
    children: children,
  );
}

Row EJRow(
  List<Widget> children, {
  MainAxisAlignment main = MainAxisAlignment.start,
  CrossAxisAlignment cross = CrossAxisAlignment.center,
  MainAxisSize size = MainAxisSize.max,
}) {
  return Row(
    mainAxisAlignment: main,
    crossAxisAlignment: cross,
    mainAxisSize: size,
    children: children,
  );
}

ListView EJListTileView<T>(List<T> items,
    {dynamic Function(int)? leading, void Function(int)? onTap}) {
  dynamic Function(int) leading_ = leading != null ? leading : (i) => items[i];

  return ListView.separated(
    itemBuilder: (_, i) => ListTile(
      leading: Text('${leading_(i)}'),
      onTap: onTap != null ? () => onTap(i) : null,
    ),
    separatorBuilder: (_, i) => Divider(),
    itemCount: items.length,
  );
}

Text EJText(String text, {Color? color, double? size}) {
  TextStyle? style;
  if (color != null || size != null) {
    style = TextStyle(color: color, fontSize: size);
  }
  return Text(text, style: style);
}

class EJEButton extends StatelessWidget {
  const EJEButton(
    this.text,
    this.onPressed, {
    super.key,
    this.hPadding,
    this.vPadding,
    this.minSize,
    this.extra,
    this.block = false,
    this.radius,
    this.foreground,
    this.background,
  });

  final double? radius;
  final String text;
  final void Function()? onPressed;
  final double? hPadding;
  final double? vPadding;
  final Size? minSize;
  final Widget? extra;
  final bool block;
  final Color? foreground;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    EdgeInsets? padding = hPadding != null || vPadding != null
        ? EdgeInsets.symmetric(
            horizontal: hPadding ?? 0, vertical: vPadding ?? 0)
        : null;
    return ElevatedButton(
        onPressed: onPressed,
        child: _child,
        style: ElevatedButton.styleFrom(
          padding: padding,
          minimumSize: minSize,
          foregroundColor: foreground,
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 4),
          ),
        ));
  }

  Widget get _child {
    var text_ = Text(text);

    return EJRow(
      [text_, if (extra != null) extra!],
      main: MainAxisAlignment.center,
      size: block ? MainAxisSize.max : MainAxisSize.min,
    );
  }
}

Container EJContainer(
  Widget? child, {
  double? radius,
  Color? color,
  double? width,
  double? height,
  double radTL = 0,
  double radTR = 0,
  double radBL = 0,
  double radBR = 0,
  bool r = false,
  double? padding,
  EdgeInsets? xpadding,
  EdgeInsets? xmargin,
}) {
  BorderRadius? bRadius;
  EdgeInsets? bPadding;
  EdgeInsets? bMargin;
  if (xmargin != null) {
    bMargin = xmargin;
  }
  if (xpadding != null) {
    bPadding = xpadding;
  } else if (padding != null) {
    bPadding = EdgeInsets.all(padding);
  }

  if (r) {
    bRadius = BorderRadius.only(
      topLeft: Radius.circular(radTL),
      topRight: Radius.circular(radTR),
      bottomLeft: Radius.circular(radBL),
      bottomRight: Radius.circular(radBR),
    );
  }
  if (radius != null) {
    bRadius = BorderRadius.all(Radius.circular(radius));
  }

  return Container(
    child: child,
    margin: bMargin,
    width: width,
    height: height,
    padding: bPadding,
    decoration: BoxDecoration(color: color, borderRadius: bRadius),
  );
}

class EJTButton extends StatelessWidget {
  const EJTButton(this.text, this.onPressed,
      {super.key,
      this.hPadding,
      this.vPadding,
      this.minSize,
      this.extra,
      this.foreground,
      this.block = false});

  final String text;
  final void Function()? onPressed;
  final double? hPadding;
  final double? vPadding;
  final Size? minSize;
  final Widget? extra;
  final bool block;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    EdgeInsets? padding = hPadding != null || vPadding != null
        ? EdgeInsets.symmetric(
            horizontal: hPadding ?? 0, vertical: vPadding ?? 0)
        : null;
    return TextButton(
        onPressed: onPressed,
        child: _child,
        style: TextButton.styleFrom(
            padding: padding,
            minimumSize: minSize,
            foregroundColor: foreground));
  }

  Widget get _child {
    var text_ = Text(text);

    return EJRow(
      [text_, if (extra != null) extra!],
      main: MainAxisAlignment.center,
      size: block ? MainAxisSize.max : MainAxisSize.min,
    );
  }
}

SizedBox EJFillH() {
  return SizedBox(width: double.infinity);
}

SizedBox EJSizedBox(Widget child, {double? width, double? height}) {
  return SizedBox(width: width, height: height, child: child);
}

class EJTextField extends StatelessWidget {
  const EJTextField(
      {super.key,
      this.width = 150,
      this.height = 50,
      this.radius = 5,
      this.hint});
  final double width;
  final double height;
  final String? hint;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
