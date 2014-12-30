part of ekans;

// The class direction to use for the arrow and to control the snake
// Source : https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:html.KeyboardEvent
class Direction {
  static const LEFT = const Direction._(0);
  static const RIGHT = const Direction._(1);
  static const UP = const Direction._(2);
  static const DOWN = const Direction._(3);
  static get values => [LEFT, RIGHT, UP, DOWN];
  final int value;
  const Direction._(this.value);
}
