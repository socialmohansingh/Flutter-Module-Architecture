abstract class DataConnectorState<T> {
  final T object;
  DataConnectorState({required this.object});
}

class DataConnectorInitial extends DataConnectorState<bool> {
  DataConnectorInitial({super.object = true});
}

enum AuthorizationConnectionType { authorized, notAuthorized }

class AuthorizationState
    extends DataConnectorState<AuthorizationConnectionType> {
  AuthorizationState({required super.object});
}

enum NetworkConnectionType { connecting, connected, notConnected }

class NetworkConnectionState extends DataConnectorState<NetworkConnectionType> {
  NetworkConnectionState({required super.object});
}
