import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class InAPPWEd extends StatefulWidget {
  const InAPPWEd({super.key});

  @override
  State<InAPPWEd> createState() => _InAPPWEdState();
}

class _InAPPWEdState extends State<InAPPWEd> {
  InAppWebViewController? inAppview;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> k = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            setState(() {
              Navigator.of(context).pop();
            });
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await inAppview!.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse(k['l']),
                ),
              );
            },
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () async {
              await inAppview!.goBack();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () async {
              await inAppview!.reload();
            },
            icon: Icon(Icons.restart_alt, color: Colors.black),
          ),
          IconButton(
            onPressed: () async {
              await inAppview!.goForward();
            },
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(k['l']),
        ),
        onWebViewCreated: (controller) {
          inAppview = controller;
        },
      ),
    );
  }
}