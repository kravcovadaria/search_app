enum SettingsStates {loading, ok, error}

class AppState {
  AppState(this.status);
  final SettingsStates status;
  AppState.init(): status = SettingsStates.loading;
}