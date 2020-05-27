
import 'package:agri_helper/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget{

  final String title;
  final String url;

  WebViewPage(this.title,{this.url : ''});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPage();
  }

}

class _WebViewPage extends BaseState<WebViewPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

}