import 'dart:ui';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

String getcurrency(String code) {
  switch (code) {
    case 'QA':
      return 'QAR';
    case 'BH':
      return 'BD';
    case 'UAE':
      return 'AED';
    case 'OM':
      return 'OMR';
    default:
      return 'QAR';
  }
}

String getcurrencyfromurl(String url) {
  switch (url) {
    case 'https://uae.ahmarket.com/':
      return 'AED';
    case 'https://oman.ahmarket.com/':
      return 'OMR';
    case 'https://bahrain.ahmarket.com/':
      return 'BHD';
    default:
      return 'QAR';
  }
}