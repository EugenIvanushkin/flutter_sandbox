import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String _LOCALE = "ru_RU";
const String _TIMESTAMP_FORMAT = "yyyy.MM.dd HH:mm:ss";

extension DateTimeTimestamp on DateTime {
  Future<String> get asTimestamp async {
    await initializeDateFormatting(_LOCALE, null);
    var result = DateFormat(_TIMESTAMP_FORMAT, _LOCALE).format(this);
    final tz = this.timeZoneOffset;
    final sign = tz >= Duration.zero ? "+" : "-";
    final hours = tz.inHours.asTwoDigits;
    final minutes = tz.inMinutes.remainder(Duration.minutesPerHour).asTwoDigits;
    result += " $sign$hours$minutes";
    return result;
  }
}

extension _NumExtension on num {
  String get asTwoDigits => this >= 10 ? "$this" : "0$this";
}
