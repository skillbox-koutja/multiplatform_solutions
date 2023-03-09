import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/core/webview/platform/base.dart';
import 'package:url_launcher/url_launcher.dart';

class AppWebView extends BaseAppWebView {
  final String source;

  const AppWebView({
    super.key,
    this.source = 'mock',
    required super.initialUrl,
    required super.buildLauncher,
  });

  @override
  State<AppWebView> createState() => _MobilePlatformWebViewState();
}

class _MobilePlatformWebViewState extends State<AppWebView> {
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
    return GestureDetector(
      child: Text(
        'link(${widget.source}): $_url',
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue,
        ),
      ),
      onTap: () {
        launchUrl(_url);
      },
    );
  }
}
