enum ProfileStatus { initial, loading, success, error }

class ProfileState {
  final ProfileStatus status;
  final Map<String, dynamic>? userProfile;
  final String? errorMessage;

  ProfileState({
    this.status = ProfileStatus.initial,
    this.userProfile,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    Map<String, dynamic>? userProfile,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}