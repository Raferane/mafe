import 'package:flutter/material.dart';
import 'package:unity_project/models/events/events_model.dart';

class EventExpansionTile extends StatelessWidget {
  final Event event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EventExpansionTile({
    required this.event,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color(0xFFF8FAFC)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: Colors.grey[300],
          collapsedBackgroundColor: const Color(0xFFF8FAFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: _getEventGradientColors()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_getEventIcon(), color: Colors.white, size: 25),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              SizedBox(height: height * 0.005),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: Color(0xFF64748B),
                  ),
                  SizedBox(width: width * 0.01),
                  Expanded(
                    child: Text(
                      event.location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF64748B),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getEventStatusBackgroundColor(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getEventStatus(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getEventStatusColor(),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                const Icon(
                  Icons.access_time,
                  size: 12,
                  color: Color(0xFF64748B),
                ),
                SizedBox(width: width * 0.01),
                Text(
                  _formatDateTime(event.dateTime),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildModernActionButton(
                icon: Icons.edit_outlined,
                color: Colors.grey[800]!,
                onTap: onEdit,
              ),
              SizedBox(width: width * 0.02),
              _buildModernActionButton(
                icon: Icons.delete_outline,
                color: const Color(0xFFEF4444),
                onTap: onDelete,
              ),
            ],
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    event.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.calendar_today,
                          title: 'Date',
                          value: _formatDate(event.dateTime),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.access_time,
                          title: 'Time',
                          value: _formatTime(event.dateTime),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.015),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.location_on,
                          title: 'Location',
                          value: event.location,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.people,
                          title: 'Participants',
                          value: '${event.participants.length} people',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.025),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onEdit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800]!,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                            ),
                          ),
                          icon: const Icon(Icons.edit_outlined, size: 18),
                          label: const Text(
                            'Edit Event',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.03),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onDelete,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEF4444),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.015,
                            ),
                          ),
                          icon: const Icon(Icons.delete_forever, size: 18),
                          label: const Text(
                            'Delete',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  bool _isEventUpcoming() => event.dateTime.isAfter(DateTime.now());

  bool _isEventToday() {
    final n = DateTime.now();
    return event.dateTime.year == n.year &&
        event.dateTime.month == n.month &&
        event.dateTime.day == n.day;
  }

  String _getEventStatus() {
    if (_isEventUpcoming()) return 'Upcoming';
    if (_isEventToday()) return 'Today';
    return 'Past';
  }

  Color _getEventStatusColor() {
    if (_isEventUpcoming()) return const Color(0xFF166534);
    if (_isEventToday()) return const Color(0xFF92400E);
    return const Color(0xFF991B1B);
  }

  Color _getEventStatusBackgroundColor() {
    if (_isEventUpcoming()) return const Color(0xFFDCFCE7);
    if (_isEventToday()) return const Color(0xFFFEF3C7);
    return const Color(0xFFFEE2E2);
  }

  List<Color> _getEventGradientColors() {
    if (_isEventUpcoming()) {
      return [const Color(0xFF10B981), const Color(0xFF059669)];
    }
    if (_isEventToday()) {
      return [const Color(0xFFF59E0B), const Color(0xFFD97706)];
    }
    return [const Color(0xFFEF4444), const Color(0xFFDC2626)];
  }

  IconData _getEventIcon() {
    if (_isEventUpcoming()) return Icons.schedule;
    if (_isEventToday()) return Icons.today;
    return Icons.event_busy;
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now(),
        today = DateTime(now.year, now.month, now.day),
        d = DateTime(dt.year, dt.month, dt.day);
    if (d == today) return 'Today';
    if (d == today.add(const Duration(days: 1))) return 'Tomorrow';
    return _formatDate(dt);
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}';
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour, minute = dt.minute, period = hour >= 12 ? 'PM' : 'AM';
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$h:${minute.toString().padLeft(2, '0')} $period';
  }

  Widget _buildModernActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 18, color: color),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E293B),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
