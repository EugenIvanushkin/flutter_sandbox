class _Constants {
  static const String PIN_KEY = "pin";
  static const String CODE_KEY = "resultCode";

  static const int SUCCESS_CODE = 100;
  static const int DISABLED_CODE = 101;
  static const int NOT_ENROLLED_CODE = 102;
  static const int NOT_RECOGNIZED_CODE = 103;
  static const int DELETED_CODE = 104;
  static const int CANCELLED_CODE = 10;
  static const int UNKNOWN_CODE = 105;

  _Constants._();
}

enum BiometricStatus {
  SUCCESS,
  DISABLED,
  NOT_ENROLLED,
  NOT_RECOGNIZED,
  DELETED,
  UNKNOWN,
  CANCELLED
}

class BiometricResult {
  final String pin;
  final BiometricStatus status;

  BiometricResult(this.pin, this.status);

  BiometricResult.empty() : this(null, BiometricStatus.UNKNOWN);

  static BiometricResult parse(dynamic data) {
    final dict = Map<String, dynamic>.from(data);
    if (dict == null || dict[_Constants.CODE_KEY] == null)
      return BiometricResult.empty();
    BiometricStatus status;
    switch (dict[_Constants.CODE_KEY] as int) {
      case _Constants.SUCCESS_CODE:
        status = BiometricStatus.SUCCESS;
        break;

      case _Constants.DISABLED_CODE:
        status = BiometricStatus.DISABLED;
        break;

      case _Constants.NOT_ENROLLED_CODE:
        status = BiometricStatus.NOT_ENROLLED;
        break;

      case _Constants.NOT_RECOGNIZED_CODE:
        status = BiometricStatus.NOT_RECOGNIZED;
        break;

      case _Constants.DELETED_CODE:
        status = BiometricStatus.DELETED;
        break;

      case _Constants.CANCELLED_CODE:
        status = BiometricStatus.CANCELLED;
        break;

      case _Constants.UNKNOWN_CODE:
      default:
        status = BiometricStatus.UNKNOWN;
        break;
    }
    return BiometricResult(dict[_Constants.PIN_KEY] as String, status);
  }
}
