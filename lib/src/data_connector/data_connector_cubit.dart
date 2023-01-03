import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/src/data_connector/data_connector_state.dart';

class DataConnectorCubit extends Cubit<DataConnectorState> {
  DataConnectorCubit() : super(DataConnectorInitial());

  void sendData(DataConnectorState state) {
    emit(state);
  }
}
