import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:todo_app/helpers/app_image_paths.dart';

import '../provider/home_provider.dart';

class QrCodeScanner extends StatefulWidget {
  QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;

              for (final barcode in barcodes) {
                print(barcode.rawValue);
                HomeProvider.of(context, isListen: false)
                    .getTodoDetails(barcode.rawValue ?? "");
              }
            },
          ),
          InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(AppImages.arrowLeft),
              ))
        ],
      ),
    );
  }
}
