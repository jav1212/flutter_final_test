import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_final_test/application/services/network/network_manager.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final INetworkManager networkManager;
  ConnectivityBloc({required this.networkManager})
      : super(const ConnectivityInitialState()) {
    on<ConnectivityInitialCheckRequested>(_checkInitialConnection);
    on<ConnectivityCheckRequested>(_checkConnection);

    add(ConnectivityInitialCheckRequested());
  }

  Future<void> _checkConnection(
      ConnectivityCheckRequested event, Emitter<ConnectivityState> emit) async {
    final subscriptionStream = networkManager.checkConnectionStream();
    await for (final isConnected in subscriptionStream) {
      isConnected
          ? emit(
              ConnectedState(willNeedReconnection: state.willNeedReconnection))
          : emit(const NotConnectedState());
    }
  }

  Future<void> _checkInitialConnection(ConnectivityInitialCheckRequested event,
      Emitter<ConnectivityState> emit) async {
    final bool isConnected = await networkManager.checkInitialConnection();
    isConnected
        ? emit(ConnectedState(willNeedReconnection: state.willNeedReconnection))
        : emit(const NotConnectedState());

    add(ConnectivityCheckRequested());
  }
}
