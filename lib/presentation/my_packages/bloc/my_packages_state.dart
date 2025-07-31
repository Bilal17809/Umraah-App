import '/core/common/cubit_state.dart';

class MyPackagesState extends BaseState {
  const MyPackagesState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
    super.data,
  });

  MyPackagesState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    dynamic data,
  }) {
    return MyPackagesState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
    );
  }
}
