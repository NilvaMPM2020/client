import 'package:asoude/model/User.dart';
import 'package:asoude/repository/ProfileRepository.dart';
import 'package:bloc/bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  User initialUser;

  ProfileBloc({this.initialUser});

  ProfileRepository _repository = ProfileRepository();

  @override
  ProfileState get initialState => ProfileUnloaded(user: initialUser);

  Stream<ProfileState> _getProfile(ProfileGet event) async* {
    User user = state.user;
    yield ProfileLoading(user: user);
    try {
      user = await _repository.getProfile(id: event.id);
      yield ProfileLoaded(user: user);
    } catch (e) {
      yield ProfileError(user: user);
    }
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileGet) {
      yield* _getProfile(event);
    }
  }
}

abstract class ProfileEvent {}

class ProfileGet extends ProfileEvent {
  int id;

  ProfileGet({this.id});
}

abstract class ProfileState {
  User user;

  ProfileState({this.user});
}

class ProfileLoaded extends ProfileState {
  ProfileLoaded({user}) : super(user: user);
}

class ProfileError extends ProfileState {
  ProfileError({user}) : super(user: user);
}

class ProfileLoading extends ProfileState {
  ProfileLoading({user}) : super(user: user);
}

class ProfileUnloaded extends ProfileState {
  ProfileUnloaded({user}) : super(user: user);
}
