abstract class BaseState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const BaseState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });
  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;
}
