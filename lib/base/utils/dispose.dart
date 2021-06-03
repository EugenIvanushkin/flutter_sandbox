import 'dart:async';

import 'package:flutter/material.dart';

/// Universal wrapper for cancel call
class Disposable {
  final Function dispose;

  Disposable(this.dispose);
}

/// Mixin for easy storage and cancelling of Disposable objects
mixin DisposeBag {
  List<Disposable> bag = [];

  void disposeBag() {
    bag.removeWhere((item) {
      item.dispose();
      return true;
    });
  }
}

/// mixin for states that hides disposeBag call
mixin DisposableState<T extends StatefulWidget, VM> on State<T>
    implements DisposeBag {
  @override
  void dispose() {
    disposeBag();
    super.dispose();
  }
}

// disposeBag extension for cancellable classes

extension StreamSubscriptionDisposeExtension on StreamSubscription {
  StreamSubscription disposeBag(List<Disposable> bag) {
    bag.add(Disposable(() => this.cancel()));
    return this;
  }
}

extension AnimationControllerDisposeExtension on AnimationController {
  AnimationController disposeBag(List<Disposable> bag) {
    bag.add(Disposable(() => this.dispose()));
    return this;
  }
}
