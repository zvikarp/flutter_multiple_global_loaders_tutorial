import 'package:flutter/material.dart';
import 'package:flutter_multiple_global_loaders_tutorial/widgets/dialog.dart';
import 'package:flutter_multiple_global_loaders_tutorial/widgets/loading.dart';

class LoadingDialogWidget extends StatelessWidget {
  LoadingDialogWidget({
    this.messages = const [],
  });

  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      margin: EdgeInsets.symmetric(horizontal: 32),
      onTapBackground: () {},
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(height: 56),
            LoadingWidget(),
            Container(height: 36),
            ...messages.map((message) => Text(message)).toList(),
            Container(height: 36),
          ],
        ),
      ),
    );
  }
}
