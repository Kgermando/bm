import 'dart:io';
import 'package:e_management/src/models/achat_model.dart';
import 'package:e_management/src/pdf/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfProductApi {
  static Future<File> generate(AchatModel achat) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(build: (context) => [


    ], 
    footer: (context) => buildFooter(achat)));
    return PdfApi.saveDocument(name: 'achats.pdf', pdf: pdf);
  }




  static Widget buildFooter(AchatModel achat) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: '', value: 'Eventdrc Technology'),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: '', value: '${DateTime.now().year}'),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
