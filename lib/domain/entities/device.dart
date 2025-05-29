enum DeviceType {
  laptop,
  phone,
  tablet,
  printer,
  monitor,
  desktop,      // PCs de escritorio
  router,       // Routers o switches
  projector,    // Proyectores (comunes en salas de reuniones)
  scanner,      // Escáneres (a veces integrados con impresoras, a veces separados)
  keyboard,     // Periféricos
  mouse,
  // ups,          // Fuentes de energía ininterrumpida
  server,       // Equipos de servidor
  speaker,      // Parlantes o sistemas de audio
  webcam,       // Cámaras externas
  accessControl, // Relojes de ingreso, biométricos, etc.
  other,        // Para lo que no encaje en ninguna categoría
}
class Device {
  final String id;
  final String name;
  final DeviceType type;
  Device({
    required this.id,
    required this.name,
    required this.type,
  });
}