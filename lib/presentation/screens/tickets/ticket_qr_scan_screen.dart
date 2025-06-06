import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class TicketQRScanScreen extends StatelessWidget {
  static const name = 'ticket-qr-scan-screen';

  const TicketQRScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Escanear dispositivo')),
      body: _QRScannerView(),
    );
  }
}
class _QRScannerView extends StatefulWidget {
  const _QRScannerView();

  @override
  State<_QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<_QRScannerView> {
  bool _isScanned = false;

  void _onDetect(BarcodeCapture capture) {
    if (_isScanned) return;

    if (capture.barcodes.isEmpty) return;
    final barcode = capture.barcodes.first;

    final String? code = barcode.rawValue;

    if (code != null && code.isNotEmpty) {
      _isScanned = true;
      context.pop(code); // Devuelve el ID escaneado
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
            facing: CameraFacing.back,
          ),
          onDetect: _onDetect,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.black54,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Escaneá el código QR del dispositivo',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
