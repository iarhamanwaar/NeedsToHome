// ignore_for_file: public_member_api_docs
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/cart_responce.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/checkout.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:async';

// ignore: must_be_immutable
class Slip extends StatefulWidget {
  Checkout con;
  Slip({this.con});
  @override
  _SlipState createState() => _SlipState();
}

class _SlipState extends State<Slip> {
  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');

    String formattedDate = formatter.format(now);
    var timeFormatter = new DateFormat.jm();
    String formattedTime = timeFormatter.format(now);
    return Scaffold(
      appBar: AppBar(title: Text('#${widget.con.saleCode}')),
      body: PdfPreview(
        build: (format) => _generatePdf(format, formattedDate, formattedTime),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, String date, time) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {
          return pw.ListView(children: [
            pw.Column(
              children: [
                pw.Text(
                  setting.value.appName,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 10),
                ),
                pw.SizedBox(height: 10),
                pw.Text(widget.con.addressShop.addressSelect,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 7)),
                pw.SizedBox(height: 5),
                pw.Text(widget.con.addressShop.phone,
                    style: pw.TextStyle(fontSize: 7)),
              ],
            ),
            pw.SizedBox(height: 10),
            /**  pw.Container(
                    decoration:pw.BoxDecoration(
                    border:pw.Border(
                    bottom: pw.BorderSide(
                    width:1,
                    color:grey,
                    )
                    )
                    )
                    ), */
            pw.SizedBox(height: 20),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                    child: pw.Container(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.ListView.builder(
                          itemCount: widget.con.productDetails.length,
    itemBuilder: (context, index) {
      CartResponce productData = widget.con.productDetails.elementAt(index);
                            return pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children:[

                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Expanded(
                                        child:pw.Text( productData.product_name,
                                            style: pw.TextStyle(fontSize: 8,fontWeight: pw.FontWeight.bold), maxLines: 1),
                                      )
                                    ]
                                ),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Expanded(
                                          child:pw.Text('${productData.variantValue}${productData.unit} x ${productData.qty}',style: pw.TextStyle(fontSize: 8))
                                      )
                                    ]
                                ),
                              ]
                            );
    }

                        ),

                      ]),
                )),
                pw.SizedBox(width: 20),
                pw.Container(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
    pw.ListView.builder(
    itemCount: widget.con.productDetails.length,
    itemBuilder: (context, index) {
    CartResponce productData = widget.con.productDetails.elementAt(index);
    return pw.Column(
    children:[
                        pw.Text(
                            (double.parse(productData.price) * productData.qty).toString(),
                            style: pw.TextStyle(fontSize: 8)),
                      pw.SizedBox(height: 14),

                    ],
                  );
    }

                  ),
                ]),

              ),
            ]),
            pw.SizedBox(height: 20),
            /**pw.Container(
                    decoration:pw.BoxDecoration(
                    border:pw.Border(
                    bottom: pw.BorderSide(
                    width:1,
                    color:grey,
                    )
                    )
                    )
                    ), */
            pw.SizedBox(height: 20),
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'PKG charges',
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Delivery Fees',
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text('Delivery Tips'),
                      pw.SizedBox(height: 10),
                      pw.Text('Delivery Tax'),
                      pw.SizedBox(height: 10),
                      pw.Text('Total',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                )),
                pw.Container(
                  child: pw.Column(
                    children: [
                      pw.Text(
                          Helper.pricePrint(widget.con.payment.packingCharge)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                          Helper.pricePrint(widget.con.payment.delivery_fees)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                          Helper.pricePrint(widget.con.payment.delivery_tips)),
                      pw.SizedBox(height: 4),
                      pw.Text(Helper.pricePrint(widget.con.payment.tax)),
                      pw.SizedBox(height: 10),
                      pw.Text(Helper.pricePrint(widget.con.payment.grand_total),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            /**  pw.Container(
                    decoration:pw.BoxDecoration(
                    border:pw.Border(
                    bottom: pw.BorderSide(
                    width:1,
                    color:grey,
                    )
                    )
                    )
                    ), */
            pw.SizedBox(height: 10),
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(date),
                    ],
                  ),
                )),
                pw.Container(
                  child: pw.Column(
                    children: [
                      pw.Text(
                        time,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            pw.SizedBox(height: 20),
            // pw.Image(pw.MemoryImage(imageJpg),width: 170,height: 50),
            pw.SizedBox(height: 10),
            /**  pw.Container(
                    decoration:pw.BoxDecoration(
                    border:pw.Border(
                    bottom: pw.BorderSide(
                    width:1,
                    color:grey,
                    )
                    )
                    )
                    ), */
            pw.SizedBox(height: 10),
            pw.Text('Thank you for your purchases!',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16),
                textAlign: pw.TextAlign.center),
            pw.SizedBox(height: 10),
            pw.Text('Payment: ${widget.con.payment.method}',
                style: pw.TextStyle(fontSize: 12),
                textAlign: pw.TextAlign.center),
            /*pw.SvgImage(
                       width: 200,
                       height:40,
                       svg:imageSvg,),*/
          ]);
        })); // Page

    return pdf.save();
  }
}
