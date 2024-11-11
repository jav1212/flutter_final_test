import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_test/application/BLoC/connectivity/connectivity_bloc.dart';
import 'package:get_it/get_it.dart';

class NetworkListener
    extends BlocListener<ConnectivityBloc, ConnectivityState> {
  NetworkListener({super.key})
      : super(
          bloc: GetIt.instance.get<ConnectivityBloc>(),
          listener: (BuildContext context, ConnectivityState state) {
            if (state is NotConnectedState || state.willNeedReconnection) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: state is NotConnectedState
                      ? const Text('No internet connection')
                      : const Text('Reconnecting...'),
                  backgroundColor:
                      state is NotConnectedState ? Colors.red : Colors.green,
                ),
              );
            }
          },
        );
}
