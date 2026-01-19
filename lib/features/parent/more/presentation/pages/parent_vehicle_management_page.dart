import 'package:flutter/material.dart';

import 'package:tcp/core/utils/avatar_image_provider.dart';
import 'package:tcp/features/parent/widgets/parent_gradient_app_bar.dart';

class _VehicleInfo {
  final String vehicleName;
  final String plateNumber;
  final String routeName;
  final String driverName;
  final String driverPhone;
  final String attendantName;
  final String attendantPhone;
  final String lastUpdated;
  final String statusLabel;
  final Color statusColor;
  final String eta;
  final String nextStop;

  const _VehicleInfo({
    required this.vehicleName,
    required this.plateNumber,
    required this.routeName,
    required this.driverName,
    required this.driverPhone,
    required this.attendantName,
    required this.attendantPhone,
    required this.lastUpdated,
    required this.statusLabel,
    required this.statusColor,
    required this.eta,
    required this.nextStop,
  });
}

class _RouteStop {
  final String title;
  final String time;
  final bool isCompleted;

  const _RouteStop({
    required this.title,
    required this.time,
    required this.isCompleted,
  });
}

class ParentVehicleManagementPage extends StatelessWidget {
  final String userName;
  final String userAvatar;

  const ParentVehicleManagementPage({
    super.key,
    required this.userName,
    required this.userAvatar,
  });

  void _showTrackSheet(BuildContext context, _VehicleInfo info) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB71C1C).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.my_location_rounded,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Live Tracking',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Tracking is demo-only right now. Wire this to your GPS/Firestore API later.',
                style: TextStyle(color: Colors.grey[700], height: 1.35),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!, width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: info.statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.directions_bus_rounded,
                        color: info.statusColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${info.vehicleName} • ${info.plateNumber}',
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Next stop: ${info.nextStop} • ETA: ${info.eta}',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.check_rounded, color: Colors.white),
                  label: const Text(
                    'Got it',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey[700])),
          ],
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey[700]),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, height: 1.25),
              children: [
                TextSpan(
                  text: '$label\n',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const info = _VehicleInfo(
      vehicleName: 'School Bus 12',
      plateNumber: 'BA 2 KHA 1234',
      routeName: 'Morning Pickup (Route A)',
      driverName: 'Ram Bahadur',
      driverPhone: '+977 98XXXXXXXX',
      attendantName: 'Sita Sharma',
      attendantPhone: '+977 98XXXXXXXX',
      lastUpdated: 'Just now',
      statusLabel: 'On Route',
      statusColor: Color(0xFF16A34A),
      eta: '12 min',
      nextStop: 'New Road Chowk',
    );

    const stops = <_RouteStop>[
      _RouteStop(title: 'Depot', time: '07:10 AM', isCompleted: true),
      _RouteStop(title: 'Putalisadak', time: '07:25 AM', isCompleted: true),
      _RouteStop(title: 'New Road Chowk', time: '07:38 AM', isCompleted: false),
      _RouteStop(title: 'School Gate', time: '07:55 AM', isCompleted: false),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const ParentGradientAppBar(
        title: 'Vehicle Management',
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 18,
          bottom: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey[200]!, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: avatarImageProvider(userAvatar),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Transport Overview',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Hi $userName — track route status and contacts.',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: info.statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: info.statusColor.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: info.statusColor,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          info.statusLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: info.statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _sectionTitle(
              'Vehicle & Route',
              subtitle: 'Last updated: ${info.lastUpdated}',
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFB71C1C,
                          ).withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.directions_bus_rounded,
                          color: Color(0xFFB71C1C),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info.vehicleName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              '${info.routeName} • ${info.plateNumber}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                          child: _infoRow(
                            icon: Icons.pin_drop_rounded,
                            label: 'Next Stop',
                            value: info.nextStop,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                          child: _infoRow(
                            icon: Icons.schedule_rounded,
                            label: 'ETA',
                            value: info.eta,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _showTrackSheet(context, info),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFB71C1C),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      icon: const Icon(
                        Icons.my_location_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Track Vehicle',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _sectionTitle('Route Timeline', subtitle: 'Today’s trip progress'),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < stops.length; i++) ...[
                    _RouteStopTile(
                      stop: stops[i],
                      isLast: i == stops.length - 1,
                    ),
                    if (i != stops.length - 1) const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),

            _sectionTitle(
              'Contacts',
              subtitle: 'Quick access to the transport team',
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Column(
                children: [
                  _ContactTile(
                    title: 'Driver',
                    name: info.driverName,
                    phone: info.driverPhone,
                    icon: Icons.badge_rounded,
                  ),
                  const SizedBox(height: 12),
                  _ContactTile(
                    title: 'Attendant',
                    name: info.attendantName,
                    phone: info.attendantPhone,
                    icon: Icons.support_agent_rounded,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!, width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFB71C1C,
                            ).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.info_outline_rounded,
                            color: Color(0xFFB71C1C),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Calling/SMS actions can be wired using url_launcher.',
                            style: TextStyle(
                              color: Colors.grey[700],
                              height: 1.25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteStopTile extends StatelessWidget {
  final _RouteStop stop;
  final bool isLast;

  const _RouteStopTile({required this.stop, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final dotColor = stop.isCompleted
        ? const Color(0xFF16A34A)
        : const Color(0xFFB71C1C);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: dotColor,
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: dotColor.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 34,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stop.title,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        stop.isCompleted ? 'Completed' : 'Upcoming',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Text(
                    stop.time,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final String title;
  final String name;
  final String phone;
  final IconData icon;

  const _ContactTile({
    required this.title,
    required this.name,
    required this.phone,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFB71C1C).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: const Color(0xFFB71C1C)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(name, style: const TextStyle(fontWeight: FontWeight.w900)),
                const SizedBox(height: 2),
                Text(phone, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Wire call action with url_launcher.'),
                ),
              );
            },
            icon: const Icon(Icons.call_rounded),
            color: const Color(0xFFB71C1C),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Wire SMS action with url_launcher.'),
                ),
              );
            },
            icon: const Icon(Icons.sms_rounded),
            color: const Color(0xFFB71C1C),
          ),
        ],
      ),
    );
  }
}
