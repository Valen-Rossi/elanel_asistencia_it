import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:elanel_asistencia_it/domain/entities/device.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    super.key,
    required this.device,
  });

  final Device device;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Material(
        color: colors.onInverseSurface,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () => context.push('/device/${device.id}'),
          highlightColor: colors.primary.withAlpha(70),
          splashColor: colors.primary.withAlpha(50),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
            child: Row(
              children: [

                Icon(device.type.icon),
                
                SizedBox(width: 17),

                Expanded(
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Text(
                        device.name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text("ID: ${device.id}")
                  
                    ],
                  ),
                ),

                Text(
                  device.type.label,
                  
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}