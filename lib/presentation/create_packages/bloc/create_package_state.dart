import '/core/common/cubit_state.dart';

class CreatePackageState extends BaseState {
  const CreatePackageState({
    super.isLoading,
    super.isSuccess,
    super.errorMessage,
  });

  CreatePackageState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return CreatePackageState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
