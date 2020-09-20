abstract class ReduxState<T> {
  T copyWith();
  List<String> whitelist;
  Map<String, dynamic> toMap();
}