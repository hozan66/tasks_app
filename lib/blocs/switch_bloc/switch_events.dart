part of 'switch_bloc.dart';

abstract class SwitchEvents extends Equatable {
  const SwitchEvents();

  @override
  List<Object?> get props => [];
}

class SwitchOnEvent extends SwitchEvents {}

class SwitchOffEvent extends SwitchEvents {}
