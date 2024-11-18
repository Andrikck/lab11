import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Модель для управління станом кольору
class ColorModel extends ChangeNotifier {
  int _red = 0;
  int _green = 0;
  int _blue = 0;

  int get red => _red;
  int get green => _green;
  int get blue => _blue;

  Color get color => Color.fromRGBO(_red, _green, _blue, 1);

  void updateRed(int value) {
    _red = value;
    notifyListeners();
  }

  void updateGreen(int value) {
    _green = value;
    notifyListeners();
  }

  void updateBlue(int value) {
    _blue = value;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorPickerScreen(),
    );
  }
}

// Головний екран з кастомними віджетами
class ColorPickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
        backgroundColor: Colors.purple[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorPreview(),
          SliderSection(),
        ],
      ),
    );
  }
}

// Віджет для відображення кольору
class ColorPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = context.watch<ColorModel>().color;
    return Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

// Віджет для секції слайдерів
class SliderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorSlider(
          label: 'Red',
          value: context.watch<ColorModel>().red.toDouble(),
          onChanged: (value) => context.read<ColorModel>().updateRed(value.toInt()),
        ),
        ColorSlider(
          label: 'Green',
          value: context.watch<ColorModel>().green.toDouble(),
          onChanged: (value) => context.read<ColorModel>().updateGreen(value.toInt()),
        ),
        ColorSlider(
          label: 'Blue',
          value: context.watch<ColorModel>().blue.toDouble(),
          onChanged: (value) => context.read<ColorModel>().updateBlue(value.toInt()),
        ),
      ],
    );
  }
}

// Кастомний віджет для одного слайдера
class ColorSlider extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  ColorSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$label: ${value.toInt()}'),
        Slider(
          value: value,
          min: 0,
          max: 255,
          divisions: 255,
          activeColor: Colors.purple,
          inactiveColor: Colors.purple.shade100,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
