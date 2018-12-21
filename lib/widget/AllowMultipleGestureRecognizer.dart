import 'package:flutter/gestures.dart';

class AllowMultipleGestureRecognizer extends VerticalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }

  @override
  String get debugDescription => "AllowMultipleGesture";
}