// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:offer_letter_app/models/user.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<File> createPdf(String empName, String empJob, String empDate) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            // pw.Align(alignment: pw.Alignment.center),
            pw.SizedBox(height: 30),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'APPOINTMENT LETTER',
                style:
                    pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.SizedBox(height: 30),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'Date: $empDate',
                style:
                    pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.right,
              ),
            ),
            pw.SizedBox(height: 30),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'ABC COMPANY PRIVATE LTD\n\n',
                style:
                    pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.left,
              ),
            ),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'B4, Flower Apartments\n\nM.G. Street, E.B. Colony\n\nMadurai - 625014',
                style: pw.TextStyle(
                  fontSize: 15,
                ),
                textAlign: pw.TextAlign.left,
              ),
            ),
            pw.SizedBox(height: 30),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'Dear $empName,\n\nWe are pleased to offer you the position of $empJob at ABC COMPANY PRIVATE LTD. We hope you will enjoy your role and make significant contributions to the success of the company. I\'m glad to have you as a part of our team. Your employment will commence on $empDate.\n\nI am looking forward to working with you.\n\n\n\n\n\nSincerely,\n\n',
                style: pw.TextStyle(
                  fontSize: 15,
                ),
                textAlign: pw.TextAlign.left,
              ),
            ),
            pw.Container(
              width: double.infinity,
              child: pw.Text(
                'HR Manager                                                                           CEO',
                style: pw.TextStyle(
                  fontSize: 15,
                ),
                textAlign: pw.TextAlign.left,
              ),
            ),
          ]);
        }));
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/OfferLetter');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  TextEditingController eName = TextEditingController();
  TextEditingController eJob = TextEditingController();
  TextEditingController eStartDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offer Letter Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: eName,
              decoration: InputDecoration(hintText: 'Enter employee name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: eJob,
              decoration: InputDecoration(hintText: 'Enter job role'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: eStartDate,
              decoration: InputDecoration(hintText: 'Enter start date'),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                child: Text("Generate Offer Letter"),
                onPressed: () async {
                  User user = User(
                      name: eName.text,
                      job: eJob.text,
                      startDate: eStartDate.text);
                  final data =
                      await createPdf(eName.text, eJob.text, eStartDate.text);
                  openFile(data);
                  // savePdf("OfferLetter", data);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
