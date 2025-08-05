abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {
  final String username;

  LoadProfileEvent({required this.username});
}

class UpdateProfileEvent extends ProfileEvent {
  final String username;
  final String email;
  final String fullName;

  UpdateProfileEvent({
    required this.username,
    required this.email,
    required this.fullName,
  });
}