abstract class BaseState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final dynamic data;

  const BaseState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.data,
  });
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}

