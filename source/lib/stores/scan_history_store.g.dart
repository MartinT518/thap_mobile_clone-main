// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScanHistoryStore on _ScanHistoryStore, Store {
  Computed<bool>? _$hasAnyComputed;

  @override
  bool get hasAny =>
      (_$hasAnyComputed ??= Computed<bool>(
            () => super.hasAny,
            name: '_ScanHistoryStore.hasAny',
          ))
          .value;

  late final _$scanHistoryAtom = Atom(
    name: '_ScanHistoryStore.scanHistory',
    context: context,
  );

  @override
  ObservableList<ProductItem> get scanHistory {
    _$scanHistoryAtom.reportRead();
    return super.scanHistory;
  }

  @override
  set scanHistory(ObservableList<ProductItem> value) {
    _$scanHistoryAtom.reportWrite(value, super.scanHistory, () {
      super.scanHistory = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_ScanHistoryStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    '_ScanHistoryStore.load',
    context: context,
  );

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$removeAsyncAction = AsyncAction(
    '_ScanHistoryStore.remove',
    context: context,
  );

  @override
  Future<void> remove(ProductItem productItem, [bool removeFromApi = true]) {
    return _$removeAsyncAction.run(
      () => super.remove(productItem, removeFromApi),
    );
  }

  late final _$_ScanHistoryStoreActionController = ActionController(
    name: '_ScanHistoryStore',
    context: context,
  );

  @override
  void add(ProductItem productItem) {
    final _$actionInfo = _$_ScanHistoryStoreActionController.startAction(
      name: '_ScanHistoryStore.add',
    );
    try {
      return super.add(productItem);
    } finally {
      _$_ScanHistoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scanHistory: ${scanHistory},
isLoading: ${isLoading},
hasAny: ${hasAny}
    ''';
  }
}
