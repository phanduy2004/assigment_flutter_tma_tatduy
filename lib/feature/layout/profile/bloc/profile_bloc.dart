import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello/feature/layout/profile/bloc/profile_event.dart';
import 'package:hello/feature/layout/profile/bloc/profile_state.dart';

import '../../../../sqlite/database_helper.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DatabaseHelper databaseHelper;

  ProfileBloc({required this.databaseHelper}) : super(ProfileState()) {
    on<LoadProfileEvent>(_onLoadProfileEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
  }

  Future<void> _onLoadProfileEvent(LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final userProfile = await databaseHelper.getUser(event.username);
      emit(state.copyWith(status: ProfileStatus.success, userProfile: userProfile));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> _onUpdateProfileEvent(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      await databaseHelper.updateUserProfile(
        username: event.username,
        email: event.email,
        fullName: event.fullName,
      );
      final userProfile = await databaseHelper.getUser(event.username);
      emit(state.copyWith(status: ProfileStatus.success, userProfile: userProfile));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()));
    }
  }
}