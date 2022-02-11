class Alert {
  final String senderName;
  final String event;
  final String description;
  final DateTime start;
  final DateTime end;

  Alert(
      {required this.start,
      required this.end,
      required this.senderName,
      required this.event,
      required this.description});

  static Alert? _fromSnapshot(Map data) {
    try {
      return Alert(
          start: DateTime.fromMillisecondsSinceEpoch(data['start'] * 1000,
                  isUtc: true)
              .toLocal(),
          end: DateTime.fromMillisecondsSinceEpoch(data['end'] * 1000,
                  isUtc: true)
              .toLocal(),
          senderName: data['sender_name'],
          event: data['event'],
          description: data['description']);
    } catch (e) {
      return null;
    }
  }

  static List<Alert> alertsToQuery(List alerts) {
    List<Alert> results = [];
    alerts.forEach((element) {
      Alert? tmp = _fromSnapshot(element);
      if (tmp != null) {
        results.add(tmp);
      }
    });
    return results;
  }
}
