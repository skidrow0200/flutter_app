import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class WalletConnectModal extends StatefulWidget {
  final String uri;
  final dynamic launchWallet;
  final dynamic closeBehavior;
  const WalletConnectModal({super.key, required this.uri, required this.launchWallet, required this.closeBehavior});

  @override
  State<WalletConnectModal> createState() => _WalletConnectModalState();
}

class _WalletConnectModalState extends State<WalletConnectModal> {
  int? groupValue = 0;
  bool qrCodeVisible = false;

  @override
  void initState() {
    super.initState();
  }

  handleSlidingWidget(value) {
    groupValue = value;
    if (groupValue == 1) {
      qrCodeVisible = true;
    } else {
      qrCodeVisible = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Container(
            width: 0.8 * width,
            height: 0.6 * height,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                      child: SizedBox(
                        height: constraints.maxHeight * 0.096,
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: const Color(0XFFB2BEB5),
                          thumbColor: Colors.white,
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                          groupValue: groupValue,
                          children: const {
                            0: Text(
                              "Mobile",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            1: Text(
                              "QRCode",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          },
                          onValueChanged: (value) {
                            handleSlidingWidget(value);
                          },
                        ),
                      ),
                    ),
                    if (qrCodeVisible == true) ...[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Align(
                          child: Text(
                              "Scan QR code with a WalletConnect-\ncompatible wallet"),
                        ),
                      ),
                      Flexible(
                        child: QrImageView(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                          data: widget.uri,
                          version: QrVersions.auto,
                          size: constraints.maxHeight * 0.6,
                          embeddedImage: const AssetImage(
                              'assets/images/wallet-connect-logo.png'),
                          embeddedImageStyle: const QrEmbeddedImageStyle(
                            size: Size(80, 80),
                          ),
                        ),
                      ),
                      TextButton(
                        child: const Text(
                            "Copy to clipboard"
                        ),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: widget.uri));
                        },
                      )
                    ] else ...[
                      const Text("Connect to Mobile Wallet"),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              color: Colors.white
                            )
                          ),
                          onPressed: () => widget.launchWallet(),
                          child: const Text("Connect"),
                        ),
                      )
                    ],
                  ],
                );
              },
            ),
          ),
        ),
        RawMaterialButton(
          onPressed: widget.closeBehavior,
          elevation: 2.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.close,
            size: 35.0,
          ),
        )
      ],
    );
  }
}

// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Color(0XFFB2BEB5)),
// height: constraints.maxHeight * 0.06,
// width: constraints.maxWidth * 0.7,
// child: Stack(
// alignment: Alignment.centerLeft,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// TextButton(
// onPressed: _selectFirst,
// child: Text("Mobile"),
// ),
// TextButton(
// onPressed: _selectSecond,
// child: Text("QRCode"),
// ),
// ],
// ),
// SlideTransition(
// position: animation,
// child: Container(
// width: width / 2,
// height: 2,
// color: Colors.blue,
// ),
// ),
// ],
// ),
// ),



// Padding(
// padding: const EdgeInsets.fromLTRB(50.0, 0, 55.0, 10.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Image(
// image: AssetImage('assets/images/wallet-connect-logo.png'),
// height: 50,
// width: 50,
// ),
// Padding(
// padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
// child: Container(
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.white,
// ),
// child: Icon(
// Icons.close,
// size: 35,
// color: Colors.black,
// ),
// ),
// )
// ],
// ),
// ),
