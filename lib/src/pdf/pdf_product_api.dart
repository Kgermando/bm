import 'dart:io';
import 'package:e_management/resources/products_database.dart';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/pdf/pdf_api.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfProductApi {
  List<AchatModel> achatList = [];
  

  Future<void> getData() async {
    List<AchatModel>? achatpdfList =
        await ProductDatabase.instance.getAllAchats();
    achatList = achatpdfList;
    
  }
  

 static Future<File> generate() async {
    final pdf = Document();

    pdf.addPage(MultiPage(
        header: (context) => headerBuilder(),
        build: (context) => [
          pw.SizedBox(height: 50),
          //  bodyBuilder(),
        ],
        footer: (context) => footerBuilder()
        ));
    return PdfApi.saveDocument(name: 'achats.pdf', pdf: pdf);
  }


  static pw.Widget headerBuilder() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Business-Management',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        pw.SizedBox(width: 2 * PdfPageFormat.mm),
        pw.Text(DateFormat("dd.MM.yy HH:mm").format(DateTime.now()),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  pw.Widget bodyBuilder() {
    
    return pw.Container(
      
        child: Column(children: [
      pw.Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
      pw.Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
      pw.Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
      pw.Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
      pw.Text('EVENTDRC TECHNOLGY',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)),
    ]));

    
  }

  static pw.Widget footerBuilder() {
    return Center(
        child: pw.Text('Business-Management',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0)));
  }
}
