import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/core/platform.dart';
import 'package:multiplatform_solutions/core/webview/platform/base.dart';
import 'package:multiplatform_solutions/core/webview/platform/mobile.dart' as mobile;
import 'package:multiplatform_solutions/core/webview/platform/mock.dart' as mock;

class AppWebView extends BaseAppWebView {
  const AppWebView({
    super.key,
    required super.initialUrl,
    required super.buildLauncher,
  });

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  @override
  Widget build(BuildContext context) {
    if (AppPlatform.isMobile) {
      return mobile.AppWebView(
        initialUrl: widget.initialUrl,
        buildLauncher: widget.buildLauncher,
      );
    }

    return mock.AppWebView(
      source: 'io',
      initialUrl: widget.initialUrl,
      buildLauncher: widget.buildLauncher,
    );
  }
}
