// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_tings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyTingsStore on _MyTingsStore, Store {
  Computed<ObservableList<ProductItem>>? _$myTingsFilteredComputed;

  @override
  ObservableList<ProductItem> get myTingsFiltered =>
      (_$myTingsFilteredComputed ??= Computed<ObservableList<ProductItem>>(
              () => super.myTingsFiltered,
              name: '_MyTingsStore.myTingsFiltered'))
          .value;
  Computed<bool>? _$hasAnyComputed;

  @override
  bool get hasAny => (_$hasAnyComputed ??=
          Computed<bool>(() => super.hasAny, name: '_MyTingsStore.hasAny'))
      .value;

  late final _$myTingsAtom =
      Atom(name: '_MyTingsStore.myTings', context: context);

  @override
  ObservableList<ProductItem> get myTings {
    _$myTingsAtom.reportRead();
    return super.myTings;
  }

  @override
  set myTings(ObservableList<ProductItem> value) {
    _$myTingsAtom.reportWrite(value, super.myTings, () {
      super.myTings = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_MyTingsStore.isLoading', context: context);

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

  late final _$displayGridAtom =
      Atom(name: '_MyTingsStore.displayGrid', context: context);

  @override
  bool get displayGrid {
    _$displayGridAtom.reportRead();
    return super.displayGrid;
  }

  @override
  set displayGrid(bool value) {
    _$displayGridAtom.reportWrite(value, super.displayGrid, () {
      super.displayGrid = value;
    });
  }

  late final _$filterTagIdAtom =
      Atom(name: '_MyTingsStore.filterTagId', context: context);

  @override
  String? get filterTagId {
    _$filterTagIdAtom.reportRead();
    return super.filterTagId;
  }

  @override
  set filterTagId(String? value) {
    _$filterTagIdAtom.reportWrite(value, super.filterTagId, () {
      super.filterTagId = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('_MyTingsStore.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$addAsyncAction =
      AsyncAction('_MyTingsStore.add', context: context);

  @override
  Future<ProductItem> add(ProductItem product) {
    return _$addAsyncAction.run(() => super.add(product));
  }

  late final _$removeAsyncAction =
      AsyncAction('_MyTingsStore.remove', context: context);

  @override
  Future<void> remove(ProductItem product) {
    return _$removeAsyncAction.run(() => super.remove(product));
  }

  late final _$updateAsyncAction =
      AsyncAction('_MyTingsStore.update', context: context);

  @override
  Future<void> update(ProductItem product) {
    return _$updateAsyncAction.run(() => super.update(product));
  }

  late final _$setDisplayModeAsyncAction =
      AsyncAction('_MyTingsStore.setDisplayMode', context: context);

  @override
  Future<void> setDisplayMode({required bool displayGrid}) {
    return _$setDisplayModeAsyncAction
        .run(() => super.setDisplayMode(displayGrid: displayGrid));
  }

  late final _$setFilterTagAsyncAction =
      AsyncAction('_MyTingsStore.setFilterTag', context: context);

  @override
  Future<void> setFilterTag(String? tagId) {
    return _$setFilterTagAsyncAction.run(() => super.setFilterTag(tagId));
  }

  @override
  String toString() {
    return '''
myTings: ${myTings},
isLoading: ${isLoading},
displayGrid: ${displayGrid},
filterTagId: ${filterTagId},
myTingsFiltered: ${myTingsFiltered},
hasAny: ${hasAny}
    ''';
  }
}
