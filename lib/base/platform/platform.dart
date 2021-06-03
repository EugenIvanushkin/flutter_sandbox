import 'package:flutter/services.dart';
import 'package:flutter_sample/base/platform/biometric.dart';

const String _DATA_CHANNEL_NAME = "app.channel.shared.data";

const String _IS_FIRST_START_METHOD = "readIsFirstStart";
const String _OPEN_SECURITY_SETTINGS_METHOD = "openSecuritySettings";
const String _DECRYPT_PINCODE_METHOD = "decryptPin";
const String _ENCRYPT_PINCODE_METHOD = "encryptPin";

const String _PIN_ARGUMENT = "pin";

Future<bool> getIsFirstStart() {
  const platform = const MethodChannel(_DATA_CHANNEL_NAME);
  return Future((){return true;});
}

Future<bool> openSecuritySettings() {
  const platform = const MethodChannel(_DATA_CHANNEL_NAME);
  return platform.invokeMethod(_OPEN_SECURITY_SETTINGS_METHOD);
}

Future<BiometricResult> decryptPinCode(String pinCode) async {
  const platform = const MethodChannel(_DATA_CHANNEL_NAME);
  final data = await platform
      .invokeMethod(_DECRYPT_PINCODE_METHOD, {_PIN_ARGUMENT: pinCode});
  return BiometricResult.parse(data);
}

Future<BiometricResult> encryptPinCode(String pinCode) async {
  const platform = const MethodChannel(_DATA_CHANNEL_NAME);
  final data = await platform
      .invokeMethod(_ENCRYPT_PINCODE_METHOD, {_PIN_ARGUMENT: pinCode});
  return BiometricResult.parse(data);
}
