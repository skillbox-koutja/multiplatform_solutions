import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/core/platform.dart';
import 'package:multiplatform_solutions/core/webview/webview.dart';

class WebViewScreen extends StatefulWidget {
  static const wideWidth = 720;

  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final TextEditingController urlController = TextEditingController(text: 'https://flutter.dev');
  final launcher = ValueNotifier<ValueChanged<Uri>>((url) {});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AppWebView(
              initialUrl: Uri.parse(urlController.text),
              buildLauncher: (launch) {
                launcher.value = launch;
              },
            ),
          ),
          _Footer(
            launcher: launcher,
            urlController: urlController,
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final ValueNotifier<ValueChanged<Uri>> launcher;
  final TextEditingController urlController;

  const _Footer({
    Key? key,
    required this.launcher,
    required this.urlController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100 + MediaQuery.of(context).padding.bottom,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: urlController,
                    decoration: const InputDecoration(
                      labelText: 'Адрес страницы',
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Load'),
                  onPressed: () {
                    try {
                      launcher.value(Uri.parse(urlController.text));
                    } on Exception {
                      const SnackBar(
                        content: Text('Повторите попытку'),
                      );
                    }
                  },
                ),
              ],
            ),
            const RunningOnMessage(),
          ],
        ),
      ),
    );
  }
}

class RunningOnMessage extends StatelessWidget {
  const RunningOnMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platform = AppPlatform.platform.name;

    return Text('APP RUNNING ON ${platform.toUpperCase()}');
  }
}
