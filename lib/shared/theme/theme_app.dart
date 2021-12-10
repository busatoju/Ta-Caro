import 'colors_app.dart';
import 'text_style_app.dart';

class ThemeApp {
  static final instance = ThemeApp();

  final _colors = ColorsApp();
  static IColorsApp get colors => instance._colors;

  final _textStyles = TextStyleApp(); 
  static ITextStyleApp get textStyles => instance._textStyles;
}