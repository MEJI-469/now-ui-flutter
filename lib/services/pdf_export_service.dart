// pdf_export_service.dart

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

// Ajusta la ruta a tu modelo
import '../models/cargar_traduccion.dart';

class PdfExportService {
  static Future<void> exportToPdfAndShare(List<CargarTraduccion> items) async {
    // 1. Crear documento PDF
    final pdfDoc = pw.Document();
    final logo = pw.MemoryImage(
      (await rootBundle.load('assets/imgs/logo-of-bw.png'))
          .buffer
          .asUint8List(),
    );
    final now = DateTime.now();

    // await PdfExportService.exportToPdfAndShare(lista);

    // 2. Opcional: Cargar fuente personalizada (si quieres).
    //    Debes colocar tu archivo TTF en assets/fonts y declararlo en pubspec.
    final customFontData =
        await rootBundle.load('assets/fonts/EBGaramond-Bold.ttf');
    final customFont = pw.Font.ttf(customFontData.buffer.asByteData());

    // 3. Definir estilos (TextStyle) para luego usar
    final myStyle =
        pw.TextStyle(font: customFont, fontSize: 42); // si usas tu fuente

    // 4. Agregar portada (opcional)
    pdfDoc.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              "Reporte de Historial",
              style: myStyle,
            ),
          );
        },
      ),
    );

    // 5. Agregar una MultiPage con header/footer
    pdfDoc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (ctx) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(logo, width: 50),
            pw.Text("Historial", style: pw.TextStyle()),
          ],
        ),
        footer: (ctx) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text("Generado: ${now.toString().substring(0, 16)}"),
            pw.Text("Página ${ctx.pageNumber} de ${ctx.pagesCount}"),
          ],
        ),
        build: (pw.Context context) {
          // Contenido: tabla + más cosas
          return [
            pw.SizedBox(height: 20),
            // Título
            pw.Text(
              "Listado de traducciones",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),

            // Llamamos un método para crear la tabla
            _buildTraduccionesTable(items),
          ];
        },
      ),
    );

    // 6. Convertir en bytes y guardar en archivo temporal
    final Uint8List pdfBytes = await pdfDoc.save();
    final tempDir = await getTemporaryDirectory();
    final filePath = "${tempDir.path}/historial_exportado.pdf";
    final file = File(filePath);
    await file.writeAsBytes(pdfBytes);

    // 7. Compartir con share_plus
    await Share.shareXFiles([XFile(filePath)], text: "Historial Exportado");
  }

  /// Retorna un widget de tipo "Table" o "Table.fromTextArray"
  static pw.Widget _buildTraduccionesTable(List<CargarTraduccion> items) {
    // Si quieres algo muy rápido, usa Table.fromTextArray
    return pw.Table.fromTextArray(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      headers: <String>["ID", "Fecha", "Texto", "Tipo"],
      data: items.map((e) {
        return [
          e.idCargarTraduccion?.toString() ?? "",
          e.fechaTraduccion,
          e.texto,
          e.tipoTraduccion
        ];
      }).toList(),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
      ),
      headerDecoration: pw.BoxDecoration(color: PdfColors.blueGrey800),
      cellStyle: const pw.TextStyle(fontSize: 12),
      cellAlignment: pw.Alignment.centerLeft,
      columnWidths: {
        0: const pw.FixedColumnWidth(40),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(4),
        3: const pw.FlexColumnWidth(2),
      },
    );
  }
}
