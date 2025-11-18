extension FutureExtensions<T> on Future<T> {
  Future<T> withMinDuration({
    Duration duration = const Duration(milliseconds: 400),
  }) async {
    final delayFuture = Future<void>.delayed(duration);
    await Future.wait([this, delayFuture]);
    return this;
  }
}
