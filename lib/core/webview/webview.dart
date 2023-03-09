/// AppWebView conditional import

export 'package:multiplatform_solutions/core/webview/platform/mock.dart'
    if (dart.library.io) 'package:multiplatform_solutions/core/webview/platform/io.dart'
    if (dart.library.html) 'package:multiplatform_solutions/core/webview/platform/html.dart';
