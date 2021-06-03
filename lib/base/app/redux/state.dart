class AppState {
  String route;

  AppState(this.route);

  AppState.empty() {
    AppState('');
  }

  Map<String, dynamic> toJson() => {'route': route};

  AppState.restoreFromJson(Map<String, dynamic> json) {
    AppState(route = (json['route'] as String));
  }
}
