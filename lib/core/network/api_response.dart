// class ApiResult {
//   final bool success;
//   final String message;
//
//   ApiResult({required this.success, required this.message,});
// }

class ApiResult<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResult({
    required this.success,
    required this.message,
    this.data,
  });
}


