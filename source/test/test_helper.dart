import 'package:get_it/get_it.dart';
import 'package:thap/services/service_locator.dart';

/// Test helper utilities
class TestHelper {
  /// Reset service locator for clean test state
  static void resetServiceLocator() {
    try {
      GetIt.instance.reset();
    } catch (e) {
      // Ignore if already reset or not initialized
    }
  }

  /// Setup service locator for tests
  static void setupServiceLocatorForTests() {
    resetServiceLocator();
    setupServiceLocator();
  }
}

