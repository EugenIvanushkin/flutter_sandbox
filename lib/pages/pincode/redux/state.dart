import 'package:flutter_sample/pages/pincode/redux/action.dart';

const String PINCODE_ATTEMPT_COUNT_KEY = "PINCODE_ATTEMPT_COUNT";
const int MAX_ATTEMPT_COUNT = 3;

enum PincodeStep { WRITE, CONFIRM }

class PincodePageState {
  final int codeLength;
  PincodeStep step = PincodeStep.WRITE;
  String pincode = "";
  String confirmPincode = "";
  ErrorActionType error;
  bool isBiometryAvailable;
  bool needToDisplaySaveBiometryAlert = false;
  int attemptCount =  0;

  PincodePageState({this.codeLength = 6});
}
