



import 'package:webview_win_floating/webview_win_floating.dart';
import 'package:fluent_ui/fluent_ui.dart' as ff;
import 'package:aqua/Custom_widget.dart';
import 'package:flutter/material.dart';

class Web extends StatefulWidget {
  const Web({Key? key}) : super(key: key);

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  final controller = WinWebViewController();


  @override
  void initState() {
    super.initState();
    //controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse("https://ahmed01ttfret.github.io/AquaView-Documentation/"));
  }

  @override
  Widget build(BuildContext context) {
    return ff.ScaffoldPage(
      padding: EdgeInsets.zero,
      header: Container(
        color: Colors.blue,
        child: ff.PageHeader(
          title: Customtext('Documentation', Colors.white),
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(Icons.keyboard_backspace_outlined,size: 30,color: Colors.white,),),
        ),
      ),

      content: Container(color: Colors.white,

      child: WinWebViewWidget(controller: controller)),



    );
  }
}


