import 'package:flutter/material.dart';

abstract class Logger {
  void info(String message);

  void debug(String message);

  void error(String message, Exception e);
}

class DefaultLogger extends Logger {
  @override
  void debug(String message) {
    debugPrint('${DateTime.now()} $message');
  }

  @override
  void error(String message, Exception e) {
    debugPrint('${DateTime.now()} $message $e');
  }

  @override
  void info(String message) {
    debugPrint('${DateTime.now()} $message');
  }
}

class LogManager {
  static final DefaultLogger _logger = DefaultLogger();

  static void info(String message) {
    _logger.info(message);
  }

  static void debug(String message) {
    _logger.debug(message);
  }

  static void error(String message, Exception e) {
    _logger.error(message, e);
  }
}
