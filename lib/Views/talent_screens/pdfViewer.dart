// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViews extends StatefulWidget {
 final String pdfLink;

 const PDFViews(this.pdfLink, {Key? key}) : super(key: key);

  @override
  State<PDFViews> createState() => _PDFViewsState();
}

class _PDFViewsState extends State<PDFViews> {


  @override
  void initState() {
    super.initState();
    // getPdfLink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           child: const PDF(enableSwipe: true,
             swipeHorizontal: true,
             autoSpacing: false,
             pageFling: false,).cachedFromUrl(
             //TODO change PDF
             'https://africau.edu/images/default/sample.pdf',
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            )
        ),
      ),
    );
  }
}
