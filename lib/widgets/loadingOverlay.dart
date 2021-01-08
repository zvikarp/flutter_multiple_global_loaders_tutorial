import 'package:flutter/material.dart';
import 'package:flutter_multiple_global_loaders_tutorial/widgets/loadingDialog.dart';

class LoadingOverlayWidget extends StatefulWidget {
  LoadingOverlayWidget({this.messages});
  final List<String> messages;

  @override
  _LoadingOverlayWidgetState createState() => _LoadingOverlayWidgetState();
}

class _LoadingOverlayWidgetState extends State<LoadingOverlayWidget> {
  @override
  Widget build(BuildContext context) {
    return LoadingDialogWidget(messages: widget.messages);
  }
}
