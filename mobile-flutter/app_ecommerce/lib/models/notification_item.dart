// lib/models/notification_item.dart
class NotificationItem {
  final String id;
  final String title;
  final String route;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.route,
    this.isRead = false,
  });
}
