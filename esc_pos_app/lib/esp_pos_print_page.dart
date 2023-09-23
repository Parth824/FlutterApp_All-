import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

class EspPosPrintPage extends StatelessWidget {
  const EspPosPrintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Esc POS'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _testTicket(),
          child: const Text('Print'),
        ),
      ),
    );
  }

  Future<List<int>> _testTicket() async {
    // Using default profile
    final profile = await CapabilityProfile.load(name: 'XP-80C');
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];
    bytes += generator.setGlobalCodeTable('WPC1252');

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Bold text', styles: PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    bytes +=
        generator.text('Align left', styles: PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
  }
}
