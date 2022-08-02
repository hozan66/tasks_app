part of 'switch_bloc.dart';

class SwitchStates extends Equatable {
  final bool switchValue;

  const SwitchStates({required this.switchValue});

  @override
  List<Object?> get props => [switchValue];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'switchValue': switchValue});

    return result;
  }

  factory SwitchStates.fromMap(Map<String, dynamic> map) {
    return SwitchStates(
      switchValue: map['switchValue'] ?? false,
    );
  }
}

class SwitchInitialState extends SwitchStates {
  const SwitchInitialState({required bool switchValue})
      : super(switchValue: switchValue);
}
