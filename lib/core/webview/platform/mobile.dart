import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/core/webview/platform/base.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            // Update loading bar.
          },
          onPageStarted: (url) {},
          onPageFinished: (url) {},
          onWebResourceError: (error) {},
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );

    controller.loadRequest(widget.initialUrl);
    widget.buildLauncher(controller.loadRequest);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}
