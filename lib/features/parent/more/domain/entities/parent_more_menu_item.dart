import 'package:tcp/features/parent/more/domain/entities/parent_more_menu_destination.dart';

class ParentMoreMenuItem {
  final ParentMoreMenuDestination destination;
  final String label;

  const ParentMoreMenuItem({
    required this.destination,
    required this.label,
  });
}
