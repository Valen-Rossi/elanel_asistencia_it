import 'package:flutter/material.dart';
enum DeviceType {
  desktopPC,
  keyboard,
  laptop,
  monitor,
  mouse,
  phone,
  printer,
  projector,
  router,
  scanner,
  speaker,
  tablet,
  ups,// uninterruptiblePowerSupply,
  other,
}

class Device {
  final String id;
  final String name;
  final DeviceType type;
  final int ticketCount;
  final DateTime lastMaintenance;

  Device({
    required this.id,
    required this.name,
    required this.type,
    required this.ticketCount,
    required this.lastMaintenance,
  });
}
// ===== DeviceType Extensions =====
extension DeviceTypeLabel on DeviceType {
  String get label {
    switch (this) {
      case DeviceType.desktopPC:
        return 'PC de escritorio';
      case DeviceType.keyboard:
        return 'Teclado';
      case DeviceType.laptop:
        return 'Laptop';
      case DeviceType.monitor:
        return 'Monitor';
      case DeviceType.mouse:
        return 'Mouse';
      case DeviceType.phone:
        return 'Teléfono';
      case DeviceType.printer:
        return 'Impresora';
      case DeviceType.projector:
        return 'Proyector';
      case DeviceType.router:
        return 'Router';
      case DeviceType.scanner:
        return 'Escáner';
      case DeviceType.speaker:
        return 'Parlante';
      case DeviceType.tablet:
        return 'Tablet';
      case DeviceType.ups:
        return 'UPS';
      case DeviceType.other:
        return 'Otro';
    }
  }
}

extension DeviceTypeIcon on DeviceType {
  IconData get icon {
    switch (this) {
      case DeviceType.laptop:
        return Icons.laptop_rounded;
      case DeviceType.phone:
        return Icons.smartphone_rounded;
      case DeviceType.scanner:
        return Icons.adf_scanner_rounded;
      case DeviceType.printer:
        return Icons.print_rounded;
      case DeviceType.monitor:
        return Icons.monitor;
      case DeviceType.desktopPC:
        return Icons.desktop_mac_rounded;
      case DeviceType.keyboard:
        return Icons.keyboard;
      case DeviceType.router:
        return Icons.router;
      case DeviceType.tablet:
        return Icons.tablet_mac_rounded;
      case DeviceType.projector:
        return Icons.fit_screen_rounded;
      case DeviceType.speaker:
        return Icons.speaker;
      case DeviceType.mouse:
        return Icons.mouse;
      case DeviceType.ups:
        return Icons.power;
      case DeviceType.other:
        return Icons.devices_other_outlined;
    }
  }
}
