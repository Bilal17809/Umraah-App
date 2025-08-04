import '/core/common/cubit_state.dart';

class UpdateProfileState extends BaseState {
  final Map<String, dynamic>? profileData;

  UpdateProfileState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
    this.profileData,
  });

  UpdateProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    Map<String, dynamic>? profileData,
  }) {
    return UpdateProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      profileData: profileData ?? this.profileData,
    );
  }
}
