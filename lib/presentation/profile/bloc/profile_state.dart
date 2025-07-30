import '../../../core/common/cubit_state.dart';

class ProfileState extends BaseState {
  final Map<String, dynamic>? profileData;

  ProfileState({
    super.isLoading,
    super.errorMessage,
    super.isSuccess,
    this.profileData,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    Map<String, dynamic>? profileData,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      profileData: profileData ?? this.profileData,
    );
  }
}
