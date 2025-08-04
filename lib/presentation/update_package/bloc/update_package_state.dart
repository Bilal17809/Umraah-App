// lib/presentation/cubit/update_package_state.dart

import '/core/common/cubit_state.dart';

class UpdatePackageState extends BaseState {
  const UpdatePackageState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
  });

  UpdatePackageState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return UpdatePackageState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
