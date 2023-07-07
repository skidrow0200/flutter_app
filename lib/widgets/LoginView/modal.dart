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

// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Padding(
// padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
// child: Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Color(0XFF808080),
// ),
// height: 0.04 * height,
// width: 0.5 * width,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text("Mobile"),
// Text("QRCode")
// ],
// ),
// ),
// ),
// Text("Connect to Mobile Wallet"),
// Flexible(
// flex: 3,
// child:
