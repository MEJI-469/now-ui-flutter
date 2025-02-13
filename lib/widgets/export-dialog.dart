import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:now_ui_flutter/services/historial_traduccion_service.dart';
import 'package:now_ui_flutter/services/pdf_export_service.dart';

class ExportDialog extends StatefulWidget {
  @override
  _ExportDialogState createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  DateTime? _startDate;
  DateTime? _endDate;

  // Por si necesitas userId
  int? _userId;

  @override
  void initState() {
    super.initState();
    _cargarUserId();
  }

  Future<void> _cargarUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getInt('userId');
    });
  }

  // Método para exportar todo
  Future<void> _exportarTodo() async {
    if (_userId == null) {
      // Error: no user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontró usuario")),
      );
      Navigator.of(context).pop(); // cierra dialog
      return;
    }

    // 1. Llama a tu método para obtener TODAS las traducciones
    //    Ajusta la ruta / método exactos según tu HistorialTraduccionService
    final allTranslations =
        await HistorialTraduccionService().obtenerHistorialPorUsuario(_userId!);

    // 2. Llama al PdfExportService
    await PdfExportService.exportToPdfAndShare(allTranslations);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Exportando TODO el historial...")),
    );

    // 3. Cierra el diálogo
    Navigator.of(context).pop();
  }

  // Método para exportar por fechas
  Future<void> _exportarRango() async {
    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No se encontró usuario")),
      );
      Navigator.of(context).pop();
      return;
    }
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selecciona ambas fechas")),
      );
      return; // no cierra, para que elija la fecha
    }

    // Formatear fecha a yyyy-MM-dd
    final startStr = _formatDate(_startDate!);
    final endStr = _formatDate(_endDate!);

    // Llama a un método en tu HistorialTraduccionService
    // p.ej. obtenerHistorialPorRango(_userId!, startStr, endStr)
    final rangeList = await HistorialTraduccionService()
        .obtenerHistorialPorRango(_userId!, startStr, endStr);

    // Exporta a PDF
    await PdfExportService.exportToPdfAndShare(rangeList);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Exportando historial entre $startStr y $endStr")),
    );

    Navigator.of(context).pop();
  }

  // Helper para formatear a yyyy-MM-dd
  String _formatDate(DateTime dt) {
    return "${dt.year.toString().padLeft(4, '0')}-"
        "${dt.month.toString().padLeft(2, '0')}-"
        "${dt.day.toString().padLeft(2, '0')}";
  }

  // Abrir date picker para fecha inicial
  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  // Abrir date picker para fecha final
  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Exportar Historial"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Selecciona rango de fechas"),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickStartDate,
                    child: Text(_startDate == null
                        ? "Fecha inicial"
                        : _formatDate(_startDate!)),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _pickEndDate,
                    child: Text(_endDate == null
                        ? "Fecha límite"
                        : _formatDate(_endDate!)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("O puedes exportar todo el historial completo"),
          ],
        ),
      ),
      actions: [
        // CANCELAR
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        // EXPORTAR TODO
        TextButton(
          onPressed: _exportarTodo,
          child: Text("Exportar Todo"),
        ),
        // EXPORTAR (filtra por fechas)
        ElevatedButton(
          onPressed: _exportarRango,
          child: Text("Exportar"),
        ),
      ],
    );
  }
}
