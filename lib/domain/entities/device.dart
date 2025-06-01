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
