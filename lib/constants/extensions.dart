import 'package:radar/constants/size_config.dart';

extension SizeExtension on double {
  double get sw => SizeConfig.width(navKey.currentContext!, this);
  double get sh => SizeConfig.height(navKey.currentContext!, this);
}
