// ignore_for_file: public_member_api_docs

import 'dart:typed_data';



import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/cart_responce.dart';
import 'package:login_and_signup_web/src/models/checkout.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';
import 'dart:async';


const PdfColor grey = PdfColor.fromInt(0x696969);
const PdfColor lightGreen = PdfColor.fromInt(0xffcdf1e7);
const PdfColor black = PdfColor.fromInt(0xFF000000);
const PdfColor white = PdfColor.fromInt(0xffffff);
const sep = 120.0;
// ignore: must_be_immutable
class A4printer extends StatefulWidget {
  Checkout con;
  A4printer({
    this.heading = 20,
    this.title =15,
    this.con
  });

  final double heading;
  final double title;
  @override
  _A4printerState createState() => _A4printerState();
}

class _A4printerState extends State<A4printer> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('#${widget.con.saleCode}')),

      body: PdfPreview(
        build: (format) => _generatePdf(format,),
      ),
    );
  }


  pw.Widget _contentTable(pw.Context context, List<CartResponce> productDetails) {


    const tableHeaders = [
      'No',
      'Item',
      'Price',
      'Quantity',
      'Total'
    ];
    //  List tableData =[][] ;

    int row = productDetails.length;
    int col = 5;

    // ignore: deprecated_member_use
    var twoDList = List.generate(row, (i) => List(col), growable: false);
    int i =0;
    productDetails.forEach((element) {
      double addonPrice = 0;
      List variantName = [];
      if(element.addon.length!=0){
        element.addon.forEach((element1) {
          var name = element1.name +' '+ '(${Helper.pricePrint(element1.price)})';
          variantName.add(name);
          addonPrice += double.parse(element1.price);
        });
        addonPrice = addonPrice * element.qty;
      } else{

      }
      twoDList[i][0] = i+1;
      if( currentUser.value.shopTypeId==2) {
        twoDList[i][1] = element.product_name + '  v' +
            '${element.quantity}, A: ${variantName.toString()} ';
      } else{
        twoDList[i][1] = element.product_name + '  v' +
            '${element.quantity}${element.unit}';
      }
      twoDList[i][2] = double.parse(element.price) + addonPrice;
      twoDList[i][3] = element.qty;
      twoDList[i][4] = double.parse(element.price)  * element.qty + (addonPrice);

      i++;
    });



    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      headerStyle: pw.TextStyle(
        color: black,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: black,
        fontSize: 10,
      ),

      headers: List<String>.generate(
        5,
            (col) => tableHeaders[col],
      ),
      data: List<List<dynamic>>.generate(
        widget.con.productDetails.length,
            (row) => List<dynamic>.generate(
          tableHeaders.length,
              (col) {

            return twoDList[row][col];
          },
        ),
      ),
    );
  }
  Future<Uint8List> _generatePdf(PdfPageFormat format,) async {
    //final imageJpg = (await rootBundle.load('assets/promakelogo.png')).buffer.asUint8List();
    final size = MediaQuery.of(context).size;
    final doc = pw.Document();

    doc.addPage(pw.Page(

        pageFormat: PdfPageFormat.a4,

        build: (pw.Context context) {

          return pw.ListView(

              children: [
                pw.Text(setting.value.appName,style:pw.TextStyle(fontSize:21,fontWeight: pw.FontWeight.bold)),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Invoice',style: pw.TextStyle(fontSize:18)),
                    pw.Text('#${widget.con.saleCode}',style: pw.TextStyle(fontSize:15))
                  ],
                ),

                pw.SizedBox(height:20),
                pw.Row(
                  children: [
                    pw.Expanded(
                        child:pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [

                              pw.Text('Billed to',),
                              pw.SizedBox(height:4),
                              pw.Text(widget.con.addressShop.username),
                              pw.SizedBox(height:4),
                              pw.Text(widget.con.addressShop.phone),
                              pw.SizedBox(height:4),
                              pw.Text(widget.con.addressShop.addressSelect),
                              pw.SizedBox(height:4),



                            ],
                          ),
                        )
                    ),
                    pw.SizedBox(width:size.width *0.1),
                    pw.Expanded(
                      child: pw.Container(
                        child:pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [

                            pw.Text('Shipped to',textAlign: pw.TextAlign.right),
                            pw.SizedBox(height:4),
                            pw.Text(widget.con.addressUser.username,textAlign: pw.TextAlign.right),
                            pw.SizedBox(height:4),
                            pw.Text(widget.con.addressUser.phone,textAlign: pw.TextAlign.right),
                            pw.SizedBox(height:4),
                            pw.Text(widget.con.addressUser.addressSelect,textAlign: pw.TextAlign.right),
                            pw.SizedBox(height:4),



                          ],
                        ),
                      ),
                    ),



                  ],
                ),
                pw.SizedBox(height:20),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [


                      pw.Container(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [

                            pw.Text('Order Date'),
                            pw.SizedBox(height:4),
                            pw.Text(widget.con.orderDate),
                            pw.Text('Payment Method'),
                            pw.Text(widget.con.payment.method)

                          ],
                        ),
                      )
                    ]
                ),

                pw.SizedBox(height:10),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Order Summary',style: pw.TextStyle(fontSize:18)),
                          pw.SizedBox(height:5),


                        ],
                      ),
                    ]
                ),
                pw.SizedBox(height:20),

                _contentTable(context,widget.con.productDetails),
                pw.SizedBox(height:20),

                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [

                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children:[
                            pw.SizedBox(height:10),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                          pw.Text('Packaging charges',style: pw.TextStyle(fontSize:12,)),

                                pw.SizedBox(width:10),
                                pw.Text(Helper.pricePrint(widget.con.payment.packingCharge),style: pw.TextStyle(fontSize:12,)),

                              ]
                            ),


                            pw.SizedBox(height:10),
          pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text('Delivery Fees',style: pw.TextStyle(fontSize:12,)),
            pw.SizedBox(width:10),
            pw.Text(Helper.pricePrint(widget.con.payment.delivery_fees),style: pw.TextStyle(fontSize:12,)),
          ]
          ),
                            pw.SizedBox(height:10),
          pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text('Tips',style: pw.TextStyle(fontSize:12,)),
            pw.SizedBox(width:10),
            pw.Text(Helper.pricePrint(widget.con.payment.delivery_tips),style: pw.TextStyle(fontSize:12,)),
          ]
          ),
                            pw.SizedBox(height:10),
                            pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text('Tax',style: pw.TextStyle(fontSize:12,)),
                                  pw.SizedBox(width:10),
                                  pw.Text(Helper.pricePrint(widget.con.payment.tax),style: pw.TextStyle(fontSize:12,)),
                                ]
                            ),
                            pw.SizedBox(height:10),
                            pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Text('Total',style:pw.TextStyle(color:grey)),
                                  pw.SizedBox(width:10),
                                  pw.Text(Helper.pricePrint(widget.con.payment.grand_total),style: pw.TextStyle(fontSize:18,)),
                                ]
                            ),



                            pw.SizedBox(height:10),


                          ]
                      ),

                    ]
                )

              ]
          );

        }
    )
    ); // Page

    return doc.save();
  }
}