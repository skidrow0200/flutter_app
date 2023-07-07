import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WalletConnectModal extends StatefulWidget {
  final String uri;
  const WalletConnectModal({super.key, required this.uri});

  @override
  State<WalletConnectModal> createState() => _WalletConnectModalState();
}

class _WalletConnectModalState extends State<WalletConnectModal> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Container(
      width: 0.8 * width,
      height: 0.4 * height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
      ),
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          return Center(
            child: QrImageView(
              data: widget.uri,
              version: QrVersions.auto,
              size: constraints.maxHeight * 0.9,
              embeddedImage: const AssetImage('assets/images/wallet-connect-logo.png'),
              embeddedImageStyle: const QrEmbeddedImageStyle(
                size: Size(80, 80),
              ),
            ),
          );
        },
      ),
    );
  }
}
