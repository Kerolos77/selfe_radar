abstract class MapState {}

class InitialMapState extends MapState {}

class ChangeLocationMapState extends MapState {}

class GetMyLocationMapState extends MapState {}

class GetMyLocationUpDateMapState extends MapState {}

class CarSpeedMapState extends MapState {}

class LocationButtonFlagMapState extends MapState {}

class LoadingCreateAlertMapState extends MapState {}

class SuccessCreateAlertMapState extends MapState {}

class ErrorCreateAlertMapState extends MapState {
  final String error;

  ErrorCreateAlertMapState(this.error);
}

class LoadingSendNotificationMapState extends MapState {}

class SuccessSendNotificationMapState extends MapState {}

class ErrorSendNotificationMapState extends MapState {
  final String error;

  ErrorSendNotificationMapState(this.error);
}