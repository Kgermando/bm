import 'dart:io';
import 'package:e_management/src/pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfProductApi {
  static Future<File> generate() async {
    final pdf = Document();

    pdf.addPage(MultiPage(
        build: (context) => [
              headerBuilder(),
              bodyBuilder()
            ],
        footer: (context) => footerBuilder()));
    return PdfApi.saveDocument(name: 'achats.pdf', pdf: pdf);
  }

  static Widget headerBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        Text('Business-MANAGEMENT',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text('${DateTime.now()}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
      ],
    );
  }

  static Widget bodyBuilder() {
    return Container(
      child: Column(
        children: [
          Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
        ]
      )
    );
  }

  static Widget footerBuilder() {
    return Center(
        child: Column(children: [
      UrlLink(
          child: Text('EVENTDRC TECHNOLGY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
          destination: 'https://eventdrc.com')
    ]));
  }
}
