import 'package:equatable/equatable.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';

part 'switch_events.dart';
part 'switch_states.dart';

class SwitchBloc extends HydratedBloc<SwitchEvents, SwitchStates> {
  SwitchBloc() : super(const SwitchInitialState(switchValue: false)) {
    on<SwitchOnEvent>((event, emit) {
      emit(const SwitchStates(switchValue: true));
    });

    on<SwitchOffEvent>((event, emit) {
      emit(const SwitchStates(switchValue: false));
    });
  }

  @override
  SwitchStates? fromJson(Map<String, dynamic> json) {
    return SwitchStates.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchStates state) {
    return state.toMap();
  }
}
