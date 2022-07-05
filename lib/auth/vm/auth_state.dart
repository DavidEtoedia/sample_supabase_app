import 'package:equatable/equatable.dart';

class AuthenticationState extends Equatable {
  final bool isloading;
  final bool isSuccess;
  final String errorMessage;
  const AuthenticationState({
    required this.isloading,
    required this.isSuccess,
    required this.errorMessage,
  });

  factory AuthenticationState.initial() {
    return const AuthenticationState(
        isloading: false, isSuccess: false, errorMessage: "");
  }

  AuthenticationState copyWith({
    final bool? isSuccess,
    final bool? isloading,
    final String? errorMessage,
  }) {
    return AuthenticationState(
        isloading: isloading ?? this.isloading,
        isSuccess: isSuccess ?? this.isSuccess,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [isloading, isSuccess, errorMessage];
}
