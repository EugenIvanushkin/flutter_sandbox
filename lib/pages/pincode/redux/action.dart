import 'package:flutter_sample/pages/pincode/redux/state.dart';

class PushAction {
  final String item;

  PushAction(this.item);
}

class DropAction {}

class ChangeStepAction {
  final PincodeStep step;

  ChangeStepAction(this.step);
}

class CheckAction {}

class UseBiometryAction {
  final bool needToShowAlert;
  UseBiometryAction(this.needToShowAlert);
}

class UseBiometryResultAction {
  final bool needToUse;

  UseBiometryResultAction(this.needToUse);
}

class ClearAction {}

class LogoutAction {}

enum ErrorActionType {
  INVALID_ATTEMPT,
  TOKEN_MISSING,
  COMMON,
  NOT_MATCH,
  BIO_DISABLED,
  BIO_NOT_ENROLLED,
  BIO_DELETED
}

class ErrorAction {
  final ErrorActionType type;

  ErrorAction(this.type);
}

// Get whether there's available biometry option

class GetBiometricStateAction {}

class BiometricStateAction {
  final bool state;

  BiometricStateAction(this.state);
}

// Password reading via biometry

class ReadBiometryProtectedPasswordAction {}

class ReadBiometryProtectedPasswordResultAction {
  final String pinCode;

  ReadBiometryProtectedPasswordResultAction(this.pinCode);
}
