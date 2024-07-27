import 'package:flutter/material.dart';
import 'package:radar/constants/size_config.dart';

extension SizeExtension on double {
  double get sw => SizeConfig.width(navKey.currentContext!, this);
  double get sh => SizeConfig.height(navKey.currentContext!, this);
}

extension BuildContextExtension on BuildContext {
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get headlineMedium => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get headlineLarge => Theme.of(this).textTheme.headlineLarge!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
}
