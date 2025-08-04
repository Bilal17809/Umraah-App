import 'package:bloc/bloc.dart';
import 'package:umraah_app/presentation/update_profile/bloc/update_profile_state.dart';
import '../../../core/local_data_storage/local_storage.dart';
import '../../../core/network/api_response.dart';
import '../../../domain/entities/update_user_profile.dart';
import '../../../domain/entities/user_entities.dart';
import '../../../domain/use-cases/update_profile.dart';
import '/domain/use-cases/profile_case.dart';
import 'package:umraah_app/presentation/profile/bloc/profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState>{
  final UpdateProfileCase _updateProfileCase;

  UpdateProfileCubit(this._updateProfileCase) : super( UpdateProfileState());

  Future<ApiResult?> updateProfile(UpdateUserProfileEntity user) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    final result = await _updateProfileCase.call(user);

    if (result != null && result.success) {
      emit(state.copyWith(
        isSuccess: true,
        isLoading: false,
        errorMessage: null,
        profileData: result.data,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: result?.message ?? 'Something went wrong',
      ));
    }

    return result;
  }

}