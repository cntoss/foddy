import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'static_color.dart';

// ignore: avoid_classes_with_only_static_members
class LightTheme {
  static const Color primaryColor = StaticColors.appColor;
  static const Color disabledTextColor = Color(0xFF718096);

  static const Color secondaryColor = StaticColors.appColor;
  static const Color disabledColor = Color(0xFFCBD5E0);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color errorColor = Color(0xFFED7662);
  static const Color backgroundColor = StaticColors.appColor;
  static const Color secondaryBackgroundColor = Color(0xFFFFFFFF);
  static const Color dividerColor = StaticColors.black5;
  static const Color inputBackgroundColor = Color(0xFF354570);
  static const Color checkboxColor = StaticColors.activeIcon;
  static const Color inputBorderColor = StaticColors.gray5;

  static const Color cardColor = Color(0xFF32353c);
  static const Color bottomNavColor = Color(0xFF1e1f23);
  static const Color appBarColor = Color(0xFF1e1f23);
  static const Color bottomSheetColor = Color(0xFF1e1f23);
  static const Color canvasColor = Color(0xFF1e1f23);
  static const Color actionColor = Color(0xFFFFFFFF);

  static ThemeData data = ThemeData(
    //fontFamily: GoogleFonts.manrope().fontFamily,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    disabledColor: disabledColor,
    //textTheme:  GoogleFonts.manropeTextTheme( text),
    cardTheme: card,
    appBarTheme: appBar,
    errorColor: errorColor,
    dividerColor: StaticColors.black5,
    buttonTheme: button,
    chipTheme: chipTheme,
    inputDecorationTheme: inputDecoration,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    outlinedButtonTheme: outlineButton,
    textButtonTheme: textButton,
    elevatedButtonTheme: elevatedButton,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateColor.resolveWith((states) {
        return checkboxColor;
      }),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        )),
    colorScheme: scheme.copyWith(secondary: secondaryColor),
    bottomNavigationBarTheme: bottomNav,
  );

  static ChipThemeData chipTheme = ChipThemeData(
      backgroundColor: Colors.white,
      disabledColor: Colors.white..withAlpha(10),
      selectedColor: Colors.white,
      padding: const EdgeInsets.all(12),
      labelPadding: const EdgeInsets.symmetric(horizontal: 18),
      secondaryLabelStyle: const TextStyle(
        color: disabledTextColor,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      labelStyle: TextStyle(
        color: disabledTextColor.withOpacity(0.64),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ));

  static BottomNavigationBarThemeData bottomNav =
      const BottomNavigationBarThemeData(
          backgroundColor: backgroundColor,
          selectedItemColor: primaryColor,
          elevation: 4,
          showSelectedLabels: false,
          unselectedLabelStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          selectedLabelStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black);

  static ColorScheme scheme = const ColorScheme.light(
    onPrimary: Colors.white,
    primary: primaryColor,
    secondary: secondaryColor,
  );

  static ButtonThemeData button = ButtonThemeData(
    buttonColor: primaryColor,
    disabledColor: disabledTextColor,
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 18,
    ),
    shape: RoundedRectangleBorder(
      side: BorderSide.none,
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static OutlinedButtonThemeData outlineButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        color: primaryColor,
        width: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 18,
      ),
      textStyle: text.button!.copyWith(
        color: primaryColor,
      ),
    ),
  );

  static ElevatedButtonThemeData elevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      onSurface: secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 18,
      ),
      textStyle: text.button!.copyWith(
        color: Colors.white,
      ),
      elevation: 0,
    ),
  );

  static TextButtonThemeData textButton = TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 18,
      ),
      textStyle: text.button!.copyWith(
        color: Colors.white,
      ),
      elevation: 0,
    ),
  );

  static CardTheme card = CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide.none,
      ));

  static AppBarTheme appBar = AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: backgroundColor,
      toolbarTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
      elevation: 0,
      shadowColor: disabledColor.withOpacity(0.1),
      actionsIconTheme: const IconThemeData(
        size: 24,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        size: 24,
        color: Colors.white,
      ));

  static InputDecorationTheme inputDecoration = InputDecorationTheme(
    filled: true,
    fillColor: inputBackgroundColor,
    contentPadding: const EdgeInsets.symmetric(
      vertical: 16,
      horizontal: 18,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(16),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: inputBorderColor,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: errorColor,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1,
        color: errorColor,
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    labelStyle: text.subtitle1!.copyWith(fontSize: 15, color: primaryColor),
    hintStyle: text.subtitle1!.copyWith(fontSize: 15),
    errorStyle: text.subtitle1!.copyWith(fontSize: 12, color: errorColor),
  );

  static TextTheme text = const TextTheme(
    // Use for body text
    bodyText1: TextStyle(
      color: textColor,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    bodyText2: TextStyle(
      color: disabledTextColor,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
    headline1: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
      fontSize: 50,
    ),
    headline2: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.3,
      fontSize: 26,
    ),
    headline3: TextStyle(
      color: textColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.2,
      fontSize: 22,
    ),
    // Use for heading text
    headline5: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    // Use for title text, AppBar
    headline6: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    // Use for sub title text
    subtitle1: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    subtitle2: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    button: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    caption: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w200,
    ),
  );
}
