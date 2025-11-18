// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_tags_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductTagsStore on _ProductTagsStore, Store {
  Computed<ObservableList<TagResult>>? _$tagsWithTingsComputed;

  @override
  ObservableList<TagResult> get tagsWithTings =>
      (_$tagsWithTingsComputed ??= Computed<ObservableList<TagResult>>(
            () => super.tagsWithTings,
            name: '_ProductTagsStore.tagsWithTings',
          ))
          .value;
  Computed<bool>? _$hasAnyComputed;

  @override
  bool get hasAny =>
      (_$hasAnyComputed ??= Computed<bool>(
            () => super.hasAny,
            name: '_ProductTagsStore.hasAny',
          ))
          .value;

  late final _$tagsAtom = Atom(
    name: '_ProductTagsStore.tags',
    context: context,
  );

  @override
  ObservableList<TagResult> get tags {
    _$tagsAtom.reportRead();
    return super.tags;
  }

  @override
  set tags(ObservableList<TagResult> value) {
    _$tagsAtom.reportWrite(value, super.tags, () {
      super.tags = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_ProductTagsStore.isLoading',
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
    '_ProductTagsStore.load',
    context: context,
  );

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$addAsyncAction = AsyncAction(
    '_ProductTagsStore.add',
    context: context,
  );

  @override
  Future<TagResult> add(String name) {
    return _$addAsyncAction.run(() => super.add(name));
  }

  late final _$renameAsyncAction = AsyncAction(
    '_ProductTagsStore.rename',
    context: context,
  );

  @override
  Future<void> rename(String tagId, String newName) {
    return _$renameAsyncAction.run(() => super.rename(tagId, newName));
  }

  late final _$updateItemCountAsyncAction = AsyncAction(
    '_ProductTagsStore.updateItemCount',
    context: context,
  );

  @override
  Future<void> updateItemCount(String tagId, int value) {
    return _$updateItemCountAsyncAction.run(
      () => super.updateItemCount(tagId, value),
    );
  }

  late final _$removeAsyncAction = AsyncAction(
    '_ProductTagsStore.remove',
    context: context,
  );

  @override
  Future<void> remove(TagResult tag) {
    return _$removeAsyncAction.run(() => super.remove(tag));
  }

  late final _$reorderAsyncAction = AsyncAction(
    '_ProductTagsStore.reorder',
    context: context,
  );

  @override
  Future<void> reorder(int oldIndex, int newIndex) {
    return _$reorderAsyncAction.run(() => super.reorder(oldIndex, newIndex));
  }

  @override
  String toString() {
    return '''
tags: ${tags},
isLoading: ${isLoading},
tagsWithTings: ${tagsWithTings},
hasAny: ${hasAny}
    ''';
  }
}
