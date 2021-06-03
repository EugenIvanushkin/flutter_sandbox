class PushRouteAction {
  final String newRoute;

  PushRouteAction(this.newRoute);
}

class PopRouteAction {
  PopRouteAction();
}

class RemoveRouteAction {
  final String removedRoute;

  RemoveRouteAction(this.removedRoute);
}

class ReplaceRouteAction {
  final String oldRoute;
  final String newRoute;

  ReplaceRouteAction(this.oldRoute, this.newRoute);
}

class ClosePageAction {
  ClosePageAction();
}
