class Cube {
  final double top;
  final double bottom;
  final double left;
  final double right;

  Cube({this.top, this.bottom, this.left, this.right});

  @override
  String toString() {
    return "Top: $top\nBottom: $bottom\nLeft: $left\nRight: $right";
  }
}
