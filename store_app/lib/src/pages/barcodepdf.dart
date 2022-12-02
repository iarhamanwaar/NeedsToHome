//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:async';


class BarCodePdf extends StatefulWidget {
  @override
  _BarCodePdfState createState() => _BarCodePdfState();
}

const PdfColor grey = PdfColor.fromInt(0x696969);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const PdfColor black = PdfColor.fromInt(0xFF000000);
const PdfColor white = PdfColor.fromInt(0xffffff);
const sep = 120.0;

class _BarCodePdfState extends State<BarCodePdf> {
  String qrData = '120';

// ignore: must_be_immutable
  Uint8List logobytes;

  final doc = pw.Document();

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: PdfPreview(
        build: (format) => _generatePdf(size, format),
      ),
    );
  }

  pw.Widget getQr() {
    return pw.Container(
        child: pw.Column(
          children: [
            pw.BarcodeWidget(
              color: PdfColor.fromHex("#000000"),
              barcode: pw.Barcode.qrCode(),
              height: 300,
              data: "120",
            ),
          ],
        ));
  }

  Future<Uint8List> _generatePdf(
      Size size,
      PdfPageFormat format,
      ) async {
    final imageJpg =
    (await rootBundle.load('assets/img/poster.jpg')).buffer.asUint8List();

    doc.addPage(pw.Page(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
              padding: pw.EdgeInsets.all(0.0),
              child: pw.Container(
                  width: size.width,
                  height: size.height * 1.5,
                  child: new pw.Stack(children: [
                    pw.Image(
                      pw.MemoryImage(imageJpg),
                      fit: pw.BoxFit.cover,
                    ),
                    pw.Positioned(
                        top: size.height * 0.4,
                        left: size.width * 0.23,
                        child: new pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.BarcodeWidget(
                            color: PdfColor.fromInt(0xFF000000),
                            barcode: pw.Barcode.qrCode(),
                            height: 100,
                            width: 100,
                            data: currentUser.value.id,
                          ),
                        )),
                    pw.Positioned(
                        top: size.height * 0.92,
                        left: size.width * 0.26,
                        child: new pw.Align(
                            alignment: pw.Alignment.center,
                            child: pw.Column(
                              children: [
                                pw.SizedBox(height: 25),
                                pw.Text(currentUser.value.id,
                                    style: pw.TextStyle(
                                        color: black,
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 35))
                              ],
                            )))
                  ])));
        })); // Page
    return doc.save();
  }
}
