import 'package:equatable/equatable.dart';

import '../../models/restaurant_model.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final Restaurant restaurant;

  const SettingsLoaded(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}
