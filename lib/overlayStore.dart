import 'package:flutter_multiple_global_loaders_tutorial/loader.dart';
import 'package:mobx/mobx.dart';

part 'overlayStore.g.dart';

class OverlayStore = _OverlayStore with _$OverlayStore;

abstract class _OverlayStore with Store {
  @observable
  ObservableList<LoaderModel> _loaders = ObservableList<LoaderModel>.of([]);

  @action
  void changeLoaderMessage(String id, String newMessage) {
    int loadersIndex = _getLoaderIndexById(id);
    if (loadersIndex < 0) return;
    LoaderModel loader = LoaderModel.clone(_loaders[loadersIndex]);
    loader.message = newMessage;
    _loaders[loadersIndex] = loader;
  }

  @action
  void addLoader(LoaderModel loader) {
    loader.startNow();
    _loaders.add(loader);
  }

  @action
  Future<void> removeLoader(String id) async {
    int loaderIndex = _getLoaderIndexById(id);
    LoaderModel loader = _loaders[loaderIndex];
    DateTime now = DateTime.now();
    DateTime finishMinDuration = loader.startTime.add(loader.minDuration);
    Duration awaitDuration = finishMinDuration.difference(now);
    await Future.delayed(awaitDuration);
    _loaders.removeWhere((element) => element.id == id);
  }

  @action
  void updateLoader(LoaderModel loader, [bool restart = false]) {
    int loaderIndex = _getLoaderIndexById(loader.id);
    if (loaderIndex < 0) return;
    if (restart) loader.startNow();
    _loaders[loaderIndex] = loader;
  }

  @computed
  List<LoaderModel> get loaders => _loaders;

  @computed
  bool get displayLoading => _loaders.any((element) => element.visible);

  int _getLoaderIndexById(String id) =>
      _loaders.indexWhere((element) => element.id == id);
}
