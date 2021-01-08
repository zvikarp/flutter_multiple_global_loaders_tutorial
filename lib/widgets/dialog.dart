import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  DialogWidget({
    @required this.child,
    this.onTapBackground,
    this.alignment = Alignment.center,
    this.margin = const EdgeInsets.all(32),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  final Widget child;
  final Alignment alignment;
  final Function onTapBackground;
  final EdgeInsets margin;
  final BorderRadius borderRadius;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTapBackground != null ? onTapBackground : () {},
          child: Container(
            alignment: alignment,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                margin: margin,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: borderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10,
                    )
                  ],
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
