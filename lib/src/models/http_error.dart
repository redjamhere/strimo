class HttpError implements Exception{
  final bool result;
  final String? error;

  const HttpError(this.result, {this.error});

  @override
  String toString() => error!;
}