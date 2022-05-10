import 'package:flutter/material.dart';

class ThemeColors {
  // Main colors
  static const MaterialColor green = MaterialColor(
      0xFF76B82A,
      const <int, Color> {
        400: const Color(0xFF90D441),
        500: const Color(0xFF76B82A),
        600: const Color(0xFF5B8E21),
      }
  );
  static const MaterialColor blue = MaterialColor(
      0xFF005B86,
      const <int, Color> {
        400: const Color(0xFF007Eb9),
        500: const Color(0xFF005B86),
        600: const Color(0xFF003853),
      }
  );
  static const MaterialColor orange = MaterialColor(
      0xFFF6A100,
      const <int, Color> {
        400: const Color(0xFFFFB52A),
        500: const Color(0xFFF6A100),
        600: const Color(0xFFC38000),
      }
  );

  static const MaterialColor bordo = MaterialColor(
      0xFFF6A100,
      const <int, Color> {
        400: const Color(0xFFA33700),
        500: const Color(0xFF5A2F00),
        600: const Color(0xFF5A2001),
      }
  );
  static const MaterialColor red = MaterialColor(
      0xFFF70015,
      const <int, Color> {
        400: const Color(0xFFFF2B3D),
        500: const Color(0xFFF70015),
        600: const Color(0xFFC40011),
      }
  );
  static const MaterialColor mint_blue = MaterialColor(
      0xFF00DDAD,
      const <int, Color> {
        400: const Color(0xFF11FFCB),
        500: const Color(0xFF00DDAD),
        600: const Color(0xFF00aa85),
      }
  );
  static const MaterialColor light_blue = MaterialColor(
      0xFF1BA8DD,
      const <int, Color> {
        400: const Color(0xFF43BBE8),
        500: const Color(0xFF1BA8DD),
        600: const Color(0xFF1585B0),
      }
  );
  static const MaterialColor pink = MaterialColor(
      0xFFFF4577,
      const <int, Color> {
        400: const Color(0xFFFF789C),
        500: const Color(0xFFFF4577),
        600: const Color(0xFFFF1252),
      }
  );
  static const MaterialColor buy_more = MaterialColor(
      0xFFB80D57,
      const <int, Color> {
        400: const Color(0xFFE8106E),
        500: const Color(0xFFB80D57),
        600: const Color(0xFF880A40),
      }
  );
  static const MaterialColor purple = MaterialColor(
      0xFFA43298,
      const <int, Color> {
        400: const Color(0xFFB838AA),
        500: const Color(0xFFA43298),
        600: const Color(0xFF902C86),
      }
  );

  // Grey colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightest_grey = Color(0xFFFAFAFA);
  static const Color lighter_grey = Color(0xFFF5F5F5);
  static const Color light_grey = Color(0xFFEEEEEE);
  static const Color grey = Color(0xFFDDDDDD);
  static const Color dark_grey = Color(0xFFAFAFAF);
  static const Color darker_grey = Color(0xFF777777);
  static const Color black = Color(0xFF000000);

  // Price colors.
  static const Color priceRegular = black;
  static const Color priceMember = orange;
  static const Color priceCampaign = red;
  static const Color priceEmployee = purple;
  static const Color priceUnknown = red;
  static const Color primaryColor = orange;
  static const Color secondaryColor = white;
  static const Color backgroundColor = blue;

  // Overlays
  static const Color modalOverlay = Color(0x80000000);
}