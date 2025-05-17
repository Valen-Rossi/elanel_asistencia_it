import 'package:timeago/timeago.dart' as timeago;

class DateTimeAgo {
  static String getTimeAgoFormat(DateTime dateTime) {
    return timeago.format(dateTime, locale: 'es', ); // para español
  }
}
