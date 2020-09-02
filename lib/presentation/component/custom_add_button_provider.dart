import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AddButtonShapePathProvider extends NeumorphicPathProvider {

  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return true;
  }

  @override
  Path getPath(Size size) {
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    final radius = size.width / 8;

    return Path()
      ..moveTo(radius, halfHeight + radius)
      // left circle
      ..arcTo(Rect.fromCircle(center: Offset(radius, halfHeight), radius: radius), 0.5 * pi, 1.0 * pi, false)
      ..lineTo(halfWidth - radius, halfHeight - radius)
      ..lineTo(halfWidth - radius, radius)
      // top circle
      ..arcTo(Rect.fromCircle(center: Offset(halfWidth, radius), radius: radius), 0.5 * pi, 1.5 * pi, false)
      ..lineTo(halfWidth + radius, halfHeight - radius)
      ..lineTo(size.width - radius, halfHeight - radius)
      // right circle
      ..arcTo(Rect.fromCircle(center: Offset(size.width - radius, halfHeight), radius: radius), 1.5 * pi, 1.0 * pi, false)
      ..lineTo(halfWidth + radius, halfHeight + radius)
      ..lineTo(halfWidth + radius, size.height - radius)
      // bottom circle
      ..arcTo(Rect.fromCircle(center: Offset(halfWidth, size.height - radius), radius: radius), 0, 1.0 * pi, false)
      ..lineTo(halfWidth - radius, halfHeight + radius)
      ..lineTo(radius, halfHeight + radius)
      ..close();
  }

  @override
  bool get oneGradientPerPath => true;

}