abstract class Result {}

class Success<T> extends Result {
  Success({this.data});
  T data;
}

class Failure extends Result {
  final String message;

  Failure({this.message = 'no message'});
}
