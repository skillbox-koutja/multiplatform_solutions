// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/core/webview/platform/base.dart';

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
  late Uri _url;

  @override
  void initState() {
    super.initState();

    _url = widget.initialUrl;

    widget.buildLauncher((url) {
      setState(() {
        _url = url;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewType = 'iframe-${Random().nextInt}';
    debugPrint(viewType);
    final iframeElement = IFrameElement()
      // ignore: unsafe_html
      ..src = _url.toString()
      ..style.border = 'none';

    // ignore: undefined_prefixed_name, avoid_dynamic_calls
    ui.platformViewRegistry.registerViewFactory(
      viewType,
      (int viewId) => iframeElement,
    );

    return HtmlElementView(viewType: viewType);
  }
}
