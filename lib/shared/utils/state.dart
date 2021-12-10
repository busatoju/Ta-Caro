typedef Empty = Function();
typedef Loading = Function();
typedef Success<T> = Function(T data);
typedef Error = Function(String message, Exception? e);
typedef OrElse = Function();

abstract class IState {
  dynamic when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse});

  static empty() => StateEmpty();
  static loading() => StateLoading();
  static success<T>(T data) => StateSuccess<T>(data);
  static error({required  String message, Exception? e}) =>
      StateError(message: message, e: e);
}

class StateEmpty extends IState {
  @override
  when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse}) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }
}

class StateLoading extends IState {
  @override
  when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse}) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }
}

class StateSuccess<T> extends IState {
  final T data;

  StateSuccess(this.data);
  @override
  when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse}) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }
}

class StateError extends IState {
  final String message;
  final Exception? e;

  StateError({
    required this.message,
    this.e,
  });

  @override
  when(
      {Empty? empty,
      Loading? loading,
      Success? success,
      Error? error,
      required OrElse orElse}) {
    if (error != null) {
      return error(message, e);
    }
    return orElse();
  }
}