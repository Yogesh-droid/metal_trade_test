import 'package:flutter/material.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebPages extends StatefulWidget {
  const AppWebPages({super.key, required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<AppWebPages> createState() => _AppWebPagesState();
}

class _AppWebPagesState extends State<AppWebPages> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: ContextMenuAppBar(title: widget.title),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: WebViewWidget(controller: controller),
    ));
  }
}
