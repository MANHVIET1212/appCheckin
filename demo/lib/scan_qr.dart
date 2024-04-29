import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  _ScanQRCode createState() => _ScanQRCode();
}

class _ScanQRCode extends State<ScanQRCode> {
  String qrResult = 'Nhấn vào đây để quét QR CODE';
  Future<void> scanQR()async{
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666','cancel',true,ScanMode.QR);
      if(!mounted)return;
      setState(() {
        this.qrResult = qrCode.toString();
      });
    }on PlatformException{
      qrResult = 'Sai';
    }
  }
  Future<void> Checkin()async{
   const url = 'https://vnem.com/test/checkthe.json';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw qrResult = 'Sai';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quét QR code'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30,),
            Text('$qrResult',style: TextStyle(color: Colors.black), ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: scanQR, child: Text('Quét QR')),
            SizedBox(height: 30,),
            
            SizedBox(height: 30,),
            ElevatedButton(onPressed: Checkin, child: Text('text send')),
             SizedBox(height: 30,),
            ///Text('$qrResult',style: TextStyle(color: Colors.black), ),
            // SizedBox(height: 30,),
            // ElevatedButton(onPressed: Checkin, child: Text('CHECK IN')),
          ],
        ),
      )
    );
  }
}