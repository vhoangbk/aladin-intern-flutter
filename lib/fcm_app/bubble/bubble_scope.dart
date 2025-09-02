// Quan ly pham vi cua bong bong chat

import 'package:flutter/material.dart';
import 'bubble_manager.dart';

class BubbleScope extends InheritedWidget {
  final BubbleManager manager;
  const BubbleScope({super.key, required this.manager, required super.child});

  static BubbleManager of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<BubbleScope>();
    assert(scope != null, 'BubbleScope not found in context');
    return scope!.manager;
  }

  @override
  bool updateShouldNotify(BubbleScope oldWidget) =>
      manager != oldWidget.manager;
}

