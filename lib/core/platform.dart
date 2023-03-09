import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

class AppPlatform {
  static final AppPlatform _instance = AppPlatform._createInstance();
  late final CustomPlatform _platform;

  static AppPlatform get instance => _instance;
  static CustomPlatform get platform => instance._platform;
  static bool get isMobile => instance._platform.isMobile;
  static bool get isDesktop => instance._platform.isDesktop;
  static bool get isUnknown => instance._platform.isUnknown;

  AppPlatform._();

  factory AppPlatform._createInstance() {
    final platform = kIsWeb ? CustomPlatform.web : CustomPlatform.fromOS();

    return AppPlatform._().._platform = platform;
  }
}

enum CustomPlatform {
  android(isMobile: true),
  ios(isMobile: true),
  web,
  linux(isDesktop: true),
  macos(isDesktop: true),
  fuchsia(isDesktop: true),
  windows(isDesktop: true),
  unknown;

  final bool isMobile;
  final bool isDesktop;

  bool get isUnknown => this == CustomPlatform.unknown;

  const CustomPlatform({
    this.isMobile = false,
    this.isDesktop = false,
  });

  factory CustomPlatform.fromOS() {
    return values.firstWhere(
      (e) => e.name == Platform.operatingSystem,
      orElse: () => CustomPlatform.unknown,
    );
  }
}
