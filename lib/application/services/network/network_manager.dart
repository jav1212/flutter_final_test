abstract class INetworkManager {
  Stream<bool> checkConnectionStream();
  Future<bool> checkInitialConnection();
}
