abstract interface class Usecase<T> {
  Future<T> call();
}