import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key, required String this.bookURL});
  final String bookURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Book Name'),
        centerTitle: true,
      ),
      body: SfPdfViewer.network(
        bookURL,
      ),
    );
  }
}
