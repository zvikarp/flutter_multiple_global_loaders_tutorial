// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overlayStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$OverlayStore on _OverlayStore, Store {
  Computed<List<LoaderModel>> _$loadersComputed;

  @override
  List<LoaderModel> get loaders =>
      (_$loadersComputed ??= Computed<List<LoaderModel>>(() => super.loaders,
              name: '_OverlayStore.loaders'))
          .value;
  Computed<bool> _$displayLoadingComputed;

  @override
  bool get displayLoading =>
      (_$displayLoadingComputed ??= Computed<bool>(() => super.displayLoading,
              name: '_OverlayStore.displayLoading'))
          .value;

  final _$_loadersAtom = Atom(name: '_OverlayStore._loaders');

  @override
  ObservableList<LoaderModel> get _loaders {
    _$_loadersAtom.reportRead();
    return super._loaders;
  }

  @override
  set _loaders(ObservableList<LoaderModel> value) {
    _$_loadersAtom.reportWrite(value, super._loaders, () {
      super._loaders = value;
    });
  }

  final _$removeLoaderAsyncAction = AsyncAction('_OverlayStore.removeLoader');

  @override
  Future<void> removeLoader(String id) {
    return _$removeLoaderAsyncAction.run(() => super.removeLoader(id));
  }

  final _$_OverlayStoreActionController =
      ActionController(name: '_OverlayStore');

  @override
  void changeLoaderMessage(String id, String newMessage) {
    final _$actionInfo = _$_OverlayStoreActionController.startAction(
        name: '_OverlayStore.changeLoaderMessage');
    try {
      return super.changeLoaderMessage(id, newMessage);
    } finally {
      _$_OverlayStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addLoader(LoaderModel loader) {
    final _$actionInfo = _$_OverlayStoreActionController.startAction(
        name: '_OverlayStore.addLoader');
    try {
      return super.addLoader(loader);
    } finally {
      _$_OverlayStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateLoader(LoaderModel loader, [bool restart = false]) {
    final _$actionInfo = _$_OverlayStoreActionController.startAction(
        name: '_OverlayStore.updateLoader');
    try {
      return super.updateLoader(loader, restart);
    } finally {
      _$_OverlayStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loaders: ${loaders},
displayLoading: ${displayLoading}
    ''';
  }
}
