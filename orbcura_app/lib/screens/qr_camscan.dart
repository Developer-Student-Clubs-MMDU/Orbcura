import 'dart:async';
import 'package:orbcura_app/screens/confirm_amount.dart';
import 'package:orbcura_app/utils/colors.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';
import 'package:orbcura_app/utils/upi_uri_parser.dart';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';

class QrCamScanPage extends StatefulWidget {
  const QrCamScanPage({super.key});

  @override
  State<QrCamScanPage> createState() => _QrCamScanPageState();
}

class _QrCamScanPageState extends State<QrCamScanPage>
    with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: false,
    torchEnabled: true,
    useNewCameraSelector: true,
  );

  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    UPIDetails? details;
    if (true) {
      try {
        details =
            UPIDetails.fromURI((barcodes.barcodes.firstOrNull?.rawValue)!);
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop()); 
        Vibration.vibrate();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmAmountPage(details!)));
      } catch (e) {
        details = null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              child: CornerSquare(
                  BorderRadius.only(topRight: borderRadius),
                  EdgeInsets.only(
                      top: primaryPadding,
                      right: primaryPadding,
                      bottom: secondaryPadding,
                      left: secondaryPadding),
                  Border(
                      top: BorderSide(
                          color: AppColors.border, width: borderWidth),
                      right: BorderSide(
                          color: AppColors.border, width: borderWidth)),
                  CornerChild(
                    Image.asset(
                      "assets/home.png",
                      height: h / 16,
                    ),
                    () {
                      Navigator.pop(context);
                    },
                  ))),
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return Text(error.toString());
            },
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }
}
