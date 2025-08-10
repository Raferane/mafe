import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/user/app_user.dart';

class UserExpansionTile extends StatelessWidget {
  final AppUser user;
  final VoidCallback onBanUser;

  const UserExpansionTile({
    required this.user,
    required this.onBanUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            color: Colors.black.withOpacity(0.08),
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
              gradient: LinearGradient(colors: _getUserGradientColors()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_getUserIcon(), color: Colors.white, size: 25),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.displayName ?? 'No Name',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    Icons.email_outlined,
                    size: 14,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      user.email,
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
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getUserStatusBackgroundColor(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getUserStatus(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getUserStatusColor(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.location_city,
                  size: 12,
                  color: Color(0xFF64748B),
                ),
                const SizedBox(width: 4),
                Text(
                  user.city.isNotEmpty ? user.city : 'No City',
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
                icon: user.isBanned ? Icons.check_circle_outline : Icons.block,
                color:
                    user.isBanned
                        ? Colors.green[600]!
                        : const Color(0xFFEF4444),
                onTap: onBanUser,
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
                    'User Information',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildUserDetailItem(
                          icon: Icons.calendar_today,
                          title: 'Joined Date',
                          value: _formatUserDate(user.createdAt),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildUserDetailItem(
                          icon: Icons.access_time,
                          title: 'Joined Time',
                          value: _formatUserTime(user.createdAt),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildUserDetailItem(
                          icon: Icons.location_city,
                          title: 'City',
                          value:
                              user.city.isNotEmpty
                                  ? user.city
                                  : 'Not specified',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildUserDetailItem(
                          icon: Icons.account_circle,
                          title: 'Account Type',
                          value:
                              user.isGoogle
                                  ? 'Google Account'
                                  : 'Email Account',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: onBanUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                user.isBanned
                                    ? Colors.green[600]!
                                    : const Color(0xFFEF4444),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          icon: Icon(
                            user.isBanned
                                ? Icons.check_circle_outline
                                : Icons.block,
                            size: 18,
                          ),
                          label: Text(
                            user.isBanned ? 'Unban User' : 'Ban User',
                            style: const TextStyle(fontWeight: FontWeight.w600),
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
  String _getUserStatus() {
    if (user.isBanned) return 'Banned';
    if (user.isAdmin) return 'Admin';
    return 'Active';
  }

  Color _getUserStatusColor() {
    if (user.isBanned) return const Color(0xFF991B1B);
    if (user.isAdmin) return const Color(0xFF166534);
    return const Color(0xFF059669);
  }

  Color _getUserStatusBackgroundColor() {
    if (user.isBanned) return const Color(0xFFFEE2E2);
    if (user.isAdmin) return const Color(0xFFDCFCE7);
    return const Color(0xFFD1FAE5);
  }

  List<Color> _getUserGradientColors() {
    if (user.isBanned)
      return [const Color(0xFFEF4444), const Color(0xFFDC2626)];
    if (user.isAdmin) return [const Color(0xFF10B981), const Color(0xFF059669)];
    return [const Color(0xFF34D399), const Color(0xFF10B981)];
  }

  IconData _getUserIcon() {
    if (user.isBanned) return Icons.block;
    if (user.isAdmin) return Icons.admin_panel_settings;
    return Icons.person;
  }

  String _formatUserDate(DateTime dt) {
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
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  String _formatUserTime(DateTime dt) {
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
        color: color.withOpacity(0.1),
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

  Widget _buildUserDetailItem({
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
