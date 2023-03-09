import 'package:flutter/material.dart';

abstract class BaseAppWebView extends StatefulWidget {
  final Uri initialUrl;
  final Function(ValueChanged<Uri>) buildLauncher;

  const BaseAppWebView({
    Key? key,
    required this.initialUrl,
    required this.buildLauncher,
  }) : super(key: key);
}
