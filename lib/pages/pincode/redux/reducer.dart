import 'package:flutter_sample/pages/pincode/redux/action.dart';
import 'package:flutter_sample/pages/pincode/redux/state.dart';

PincodePageState pincodeReducers(PincodePageState state, dynamic action) {
  if (action is PushAction) return _pushAction(state, action);
  if (action is ChangeStepAction) return _changeStepAction(state, action);
  if (action is DropAction) return _dropAction(state, action);
  if (action is ErrorAction) return _errorAction(state, action);
  if (action is ClearAction) return _clearAction(state, action);
  if (action is BiometricStateAction) return _biometricAction(state, action);
  if (action is UseBiometryAction)
    return _useBiometryForPassword(state, action);
  if (action is ReadBiometryProtectedPasswordResultAction)
    return _biometricResponse(state, action);
  return state;
}

PincodePageState _biometricResponse(
    PincodePageState state, ReadBiometryProtectedPasswordResultAction action) {
  return state..pincode = action.pinCode;
}

PincodePageState _pushAction(PincodePageState state, PushAction action) {
  if (state.step == PincodeStep.WRITE &&
      state.pincode.length < state.codeLength) {
    state.pincode += action.item;
  }
  if (state.step == PincodeStep.CONFIRM &&
      state.confirmPincode.length < state.codeLength) {
    state.confirmPincode += action.item;
  }
  return state;
}

PincodePageState _changeStepAction(
    PincodePageState state, ChangeStepAction action) {
  return state..step = action.step;
}

PincodePageState _dropAction(PincodePageState state, DropAction action) {
  if (state.step == PincodeStep.CONFIRM && state.confirmPincode.isNotEmpty) {
    state.confirmPincode = state.confirmPincode.droppedLast();
  }
  if (state.step == PincodeStep.WRITE && state.pincode.isNotEmpty) {
    state.pincode = state.pincode.droppedLast();
  }
  return state;
}

PincodePageState _errorAction(PincodePageState state, ErrorAction action) {
  if (action.type == ErrorActionType.INVALID_ATTEMPT) {
    state.attemptCount += 1;
  }
  state.error = action.type;
  return state;
}

PincodePageState _clearAction(PincodePageState state, ClearAction action) {
  return state
    ..confirmPincode = ""
    ..pincode = ""
    ..step = PincodeStep.WRITE;
}

PincodePageState _biometricAction(
    PincodePageState state, BiometricStateAction action) {
  return state..isBiometryAvailable = action.state;
}

PincodePageState _useBiometryForPassword(
    PincodePageState state, UseBiometryAction action) {
  return state..needToDisplaySaveBiometryAlert = action.needToShowAlert;
}

extension _StringExtension on String {
  String droppedLast() {
    if (isEmpty) return this;
    return substring(0, length - 1);
  }
}
