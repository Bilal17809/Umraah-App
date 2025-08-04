// import '/core/common/cubit_state.dart';
//
// class MyPackagesState extends BaseState {
//   const MyPackagesState({
//     super.isLoading,
//     super.errorMessage,
//     super.isSuccess,
//     super.data,
//   });
//
//   MyPackagesState copyWith({
//     bool? isLoading,
//     String? errorMessage,
//     bool? isSuccess,
//     dynamic data,
//   }) {
//     return MyPackagesState(
//       isLoading: isLoading ?? this.isLoading,
//       errorMessage: errorMessage ?? this.errorMessage,
//       isSuccess: isSuccess ?? this.isSuccess,
//       data: data ?? this.data,
//     );
//   }
// }
import '../../../data/model/create_package.dart';

class MyPackagesState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final List<CreatePackageModel>? data;

  const MyPackagesState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.data,
  });

  MyPackagesState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    List<CreatePackageModel>? data,
  }) {
    return MyPackagesState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      data: data ?? this.data,
    );
  }
}
