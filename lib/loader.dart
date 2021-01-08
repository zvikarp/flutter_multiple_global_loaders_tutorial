import 'package:flutter/widgets.dart';

class LoaderModel {
  LoaderModel({
    String id,
    this.message,
    this.visible = true,
    this.index = 1,
    this.startTime,
    this.minDuration = const Duration(seconds: 0),
  }) : id = id ?? UniqueKey().toString();

  String id;
  String message;
  bool visible;
  int index;
  DateTime startTime;
  Duration minDuration;

  factory LoaderModel.clone(LoaderModel loader) => LoaderModel(
        id: loader.id,
        message: loader.message,
        visible: loader.visible,
        index: loader.index,
        startTime: loader.startTime,
        minDuration: loader.minDuration,
      );

  void startNow() => startTime = DateTime.now();
}
